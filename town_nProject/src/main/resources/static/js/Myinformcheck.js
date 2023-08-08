function check (){
	var getID = RegExp(/^[a-zA-Z0-9]{4,12}$/);
    var getkorname = RegExp(/^[가-힣]+$/);
    var getengname = RegExp(/^[a-zA-Z]+$/);
    var getMail = RegExp(/^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/);
    var getPhone = RegExp(/^[0-9]{2,3}-[0-9]{3,4}-[0-9]{4}$/);
    
    if(!getID.test($("#id").val())){
        alert("ID형식을 확인해주세요");
        $("#id").val("");
        $("#id").focus();
        return false;
    }

    if(getkorname.test($("#name").val()) || getengname.test($("#name").val())){
        
     }
 
     else{
         alert("성함을 정확히 입력해주세요");
         $("#name").val("");
         $("#name").focus();
         return false;
     }
    
    if(!getPhone.test($("#phone").val())){
        alert("휴대폰번호를 확인해주세요");
        $("#phone").val("");
        $("#phone").focus();
        return false;
    }

    if(!getMail.test($("#email").val())){
        alert("이메일형식에 맞게 입력해주세요");
        $("#mail").val("");
        $("#mail").focus();
        return false;
    }
    
    alert("회원정보수정이 완료되었습니다.");
    
}