var test;
function numCheck1(){

    var email = $("#email").val(); 
        
        $.ajax({
            type : 'post',
            url : '/CheckMail',
            data : {
                email:email
                },
            success : function(data){
				test = data;
				$('#test').text(test);
				}
        });
        alert("인증번호가 전송되었습니다.")
    
    $("#num-st").css("display","none");
    $("#num-st1").css("display","inline-block"); 
    
    

}

function emailnum(){
	if($("#num").val() == test){
				$("#result-1").text("이메일 인증을 완료했습니다.");
					}
					else{
				$("#result-1").text("이메일 인증번호를 다시 확인해주세요.");
				$('#join').removeClass('on');
				$('#join').attr("disabled",true);
				}
}
