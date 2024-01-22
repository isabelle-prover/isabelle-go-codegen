chapter AFP

session Go = HOL +
  description "A Go frontend for the code generator."
  options [timeout = 300]
  theories
    Go_Setup
  document_files
    "root.tex"

session Go_Test_Quick in "test/quick" = Go +
  description "Quick test session with BigInts and RBTs"
  options [timeout = 300]
  sessions
    "HOL-Data_Structures"
  theories [document = false, condition = "ISABELLE_GO"]
    RBT_Test
  export_files [3]
    "*:code/export1/**"

session Go_Test_Slow in "test/slow" = "HOL-Library" +
  description "Slow test session for (almost) the entire HOL-Library"
  options [timeout = 1200]
  sessions
    Go
    "HOL-Number_Theory"
    "HOL-Data_Structures"
    "HOL-Examples"
  theories [document = false, condition = "ISABELLE_GO"]
    Candidates
    Generate
    Generate_Binary_Nat