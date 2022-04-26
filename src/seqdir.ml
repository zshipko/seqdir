let listdir path : string Seq.t =
  Seq.flat_map Fun.id (fun () ->
      let files = try Sys.readdir path |> Array.to_seq with _ -> Seq.empty in
      Seq.Cons (files, Seq.empty))

let file_kind filename =
  try
    let st = Unix.stat filename in
    Some st.st_kind
  with _ -> None

module File = struct
  type t = [ `Dir of string | `File of string ]

  let to_string = function `Dir f -> f | `File f -> f

  let pp fmt = function
    | `File f -> Format.fprintf fmt "FILE %s" f
    | `Dir f -> Format.fprintf fmt "DIR %s" f

  let equal a b =
    match (a, b) with
    | `File f, `File g | `Dir f, `Dir g -> String.equal f g
    | _ -> false
end

let rec list ?(max_depth = -1) path : File.t Seq.t =
  let open Unix in
  let path' = Unix.realpath path in
  let files = listdir path' in
  let recurse = max_depth > 0 || max_depth < 0 in
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
