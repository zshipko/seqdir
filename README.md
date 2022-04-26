# Seqdir

An OCaml package for recursively listing files

## Installation

Using opam:

```shell
$ opam pin add git+https://github.com/zshipko/seqdir
```

## Usage

`Seqdir.list` can be used to generate a sequence of filenames. For example, to list recursively all files in `/tmp`:

```ocaml
let () =
  let filenames =
    Seqdir.list "/tmp"
    |> Seq.map Seqdir.Entry.filename
  in
  Seq.iter print_endline filenames
```

It's also possible to limit the depth using the optional `max_depth` parameter:

```ocaml
Seqdir.list ~max_depth:1 "/tmp"
```
