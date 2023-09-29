session Go = "HOL-Library" +
  description "
    A Go frontend for the code generator.
  "
  theories [document = false]
   Go_Setup

session "Go_Test" in go_test = Go +
  description "
    A couple tests for the generator's Go output
  "
  sessions
    "HOL-Number_Theory"
    "HOL-Data_Structures"
    "HOL-Examples"
  theories [document = false]
   Candidates
   Generate
   Generate_Binary_Nat
   RBT_Test
  export_files [3]
   "*:code/export1/**"
