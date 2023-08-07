function check (){
	var getID = RegExp(/^[a-zA-Z0-9]{4,12}$/);
    var getCheck = RegExp(/^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,15}$/);
    
    if(!getID.test($("#id").val())){
        alert("아이디 또는 비밀번호를 확인해주세요.");
        $("#id").val("");
        $("#id").focus();
        return false;
    }

    if(!getCheck.test($("#password").val())){
        alert("아이디 또는 비밀번호를 확인해주세요.");
        $("#pw").val("");
        $("#pw").focus();
        return false;
    }
    
}