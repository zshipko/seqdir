let depth = ref (-1)
let path = ref "."
let only_files = ref false
let only_dirs = ref false
let anon_fun s = path := s
let usage = "seqdir [-d DEPTH] PATH"

let speclist =
  [
    ("-n", Arg.Set_int depth, "Set depth");
    ("-f", Arg.Set only_files, "Only files");
    ("-d", Arg.Set only_dirs, "Only directories");
  ]

let () = Arg.parse speclist anon_fun usage

let () =
  let files =
    if (not !only_files) && not !only_dirs then true else !only_files
  in
  let dirs = if (not !only_files) && not !only_dirs then true else !only_dirs in
  Seqdir.list ~max_depth:!depth !path
  |> Seq.filter (function `File _ -> files | `Dir _ -> dirs)
  |> Seq.iter (function
       | `Dir f -> Printf.printf "DIR %s\n" f
       | `File f -> Printf.printf "FILE %s\n" f)
