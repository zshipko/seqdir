(lang dune 3.0)

(cram enable)

(name seqdir)

(generate_opam_files true)

(source
 (github zshipko/seqdir))

(authors "Zach Shipko")

(maintainers "Zach Shipko")

(license ISC)

(documentation https://github.com/zshipko/seqdir)

(package
 (name seqdir)
 (synopsis "A package to make listing files easier")
 (description "Seqdir can be used to create a sequence of file names contained in a directory")
 (depends ocaml dune)
 (tags
  (listdir ls)))

