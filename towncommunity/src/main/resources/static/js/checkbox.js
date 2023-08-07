$(document).ready(function(){
    $("#mark").change(function(){
     
     if($(this).is(':checked')){
      $("#pw").attr("type","text");
     }
     else{
      $("#pw").attr("type","password");
     }
    
    });

    $("#mark1").change(function(){

        if($(this).is(':checked')){
         $("#pw2").attr("type","text");
        }
        else{
         $("#pw2").attr("type","password");
        }
       
       
       });
   });