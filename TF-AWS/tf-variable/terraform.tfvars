 aws_instance_type = "t2.micro"
 ec2_config = {
    v_size = 20
    v_type = "gp2"
 }

 additional_tag = {
   DEPT = "QA"
   PROJECT = "MYPROJECT_QA"
 }