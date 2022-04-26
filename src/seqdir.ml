let listdir path : string Seq.t =
  Seq.concat (fun () ->
      let files = try Sys.readdir path |> Array.to_seq with _ -> Seq.empty in
      Seq.Cons (files, Seq.empty))

let file_kind filename =
  try
    let st = Unix.stat filename in
    Some st.st_kind
  with _ -> None

module Entry = struct
  type t = [ `Dir of string | `File of string ]

  let filename = function `Dir f -> f | `File f -> f

  let pp fmt = function
    | `File f -> Format.fprintf fmt "FILE %s" f
    | `Dir f -> Format.fprintf fmt "DIR %s" f

  let equal a b =
    match (a, b) with
    | `File f, `File g | `Dir f, `Dir g -> String.equal f g
    | _ -> false
end

let rec list ?(max_depth = -1) path : Entry.t Seq.t =
  let open Unix in
  let full_path =
    try realpath path with
    | Unix_error (ENOENT, _, x) -> raise (Unix_error (ENOENT, "Seqdir.list", x))
    | exn -> raise exn
  in
  let files = listdir full_path in
  let recurse = max_depth > 1 || max_depth < 0 in
  Seq.flat_map
    (fun f ->
      let f = Filename.concat path f in
      match file_kind f with
      | Some S_DIR when recurse ->
          let acc = list ~max_depth:(max_depth - 1) f in
          Seq.cons (`Dir f) acc
      | Some S_DIR -> Seq.return (`Dir f)
      | Some S_REG -> Seq.return (`File f)
      | Some S_LNK | Some S_BLK | Some S_CHR | Some S_SOCK | Some S_FIFO | None
        ->
          Seq.empty)
    files
