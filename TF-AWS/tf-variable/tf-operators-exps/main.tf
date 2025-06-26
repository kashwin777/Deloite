terraform {}

# number list
variable "num_lis" {
  type    = list(number)
  default = [1, 2, 3, 4, 5]
}


# Object list
variable "person_list" {
    type = list(object({
        fname = string
        lname = string
    }))
         default = [ {
           fname= "raju"
           lname = "rastogi"
         }, {
            fname = "sham"
           lname = "paul"
         }]
           
}

# map list
 variable "map_list" {
   type = map(number)
   default = {
     "one" = 1
    "two" = 2
    "three" =3
   }
 }

 # calculations
 locals {
   mul = 2 * 6
   add = 10 + 25
   eq = 2 != 3
 }

 output "output" {
    value = var.num_lis
    
    
   
 }
 

