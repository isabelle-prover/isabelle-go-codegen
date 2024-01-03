session Go = HOL +
  description "A Go frontend for the code generator."
  theories
    Go_Setup

session Go_Test_Quick in "test/quick" = Go +
  description "Quick test session with BigInts and RBTs"
  sessions
    "HOL-Data_Structures"
  theories [document = false]
    RBT_Test
  export_files [3]
    "*:code/export1/**"

session Go_Test_Slow in "test/slow" = "HOL-Library" +
  description "Slow test session for (almost) the entire HOL-Library"
  sessions
    Go
    "HOL-Number_Theory"
    "HOL-Data_Structures"
    "HOL-Examples"
  theories [document = false]
    Candidates
    Generate
    Generate_Binary_Nat