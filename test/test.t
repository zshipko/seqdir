Create some files
  $ touch A
  $ mkdir B
  $ touch B/C
  $ ln -s B D

List all files and directories
  $ seqdir .
  DIR ./B
  FILE ./B/C
  DIR ./D
  FILE ./D/C
  FILE ./A

List files
  $ seqdir -f .
  FILE ./B/C
  FILE ./D/C
  FILE ./A

List directories
  $ seqdir -d .
  DIR ./B
  DIR ./D

List max_depth=1
  $ seqdir -n 1 .
  DIR ./B
  DIR ./D
  FILE ./A

List max_depth=2
  $ seqdir -n 2 .
  DIR ./B
  FILE ./B/C
  DIR ./D
  FILE ./D/C
  FILE ./A

