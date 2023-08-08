function check (){
    var getCheck = RegExp(/^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,15}$/);

    if(!getCheck.test($("#password").val())){
        alert("비밀번호 확인을 확인해주세요. 숫자,영문,특수문자 포함 8~15자로 입력해주세요");
        $("#pw").val("");
        $("#pw").focus();
        return false;
    }
    
    if(!getCheck.test($("#password2").val())){
        alert("비밀번호 확인을 확인해주세요. 숫자,영문,특수문자 포함 8~15자로 입력해주세요");
        $("#pw2").val("");
        $("#pw2").focus();
        return false;
    }

    if ($("#password").val() != $("#password2").val()){
        alert("비밀번호가 상이합니다.");
        $("#pw").val("");
        $("#pw2").val("");
        $("#pw").focus();
        return false;
    }
    if(($("#password").val()=""||($("#password").val()===""))||$("#nowpassword").val()){
		alert("비밀번호를 입력해주세요");
		return false;
	}
    

    
}