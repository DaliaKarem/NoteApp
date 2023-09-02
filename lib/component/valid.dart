validInput(String val,int min,int max)
{
 if (val.isEmpty)
 {
  return "this field is required";
 }
 if(val.length>max)
  {
   return " input should be smaller than $max";
  }
 if(val.length<min)
  {
   return " input should be greeter than $min ";
  }

}