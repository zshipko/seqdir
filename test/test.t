Create some files
  $ touch A
  $ mkdir B
  $ touch B/C

List all files and directories
  $ seqdir .
  DIR ./B
  FILE ./B/C
  FILE ./A

List files
  $ seqdir -f .
  FILE ./B/C
  FILE ./A

List files
  $ seqdir -d .
  DIR ./B

