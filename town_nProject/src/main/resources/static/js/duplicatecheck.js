 function checkeID(){
	 
        var member_id = $('#id').val(); 
        var getID = RegExp(/^[a-zA-Z0-9]+[a-zA-Z0-9]{4,12}$/);
        if(!getID.test($("#id").val())){
        $(".duID").text("영문,숫자 포함 4~12자 입력해주세요.");
        $('.duID').css("color","red"); 
    	}
        $.ajax({
            url:'/dupliIDCheck', 
            type:'post', 
            data:{member_id:member_id},
            success:function(cnt){ 
				if(getID.test($("#id").val())){
	                if(cnt == 0){ 
	                    $(".duID").text("가입 가능한 ID입니다.");
	                    $('.duID').css("color","blue"); 
	                    
	                } else { 
	                    $(".duID").text("가입이 완료된 ID입니다.");
	                    $('.duID').css("color","red"); 
	                    $('#join').attr("disabled",true);
	                }
                }
            }
        });
        };
 function checkEmail(){
	 
        var email = $('#email').val(); 
        var getEmail = RegExp(/^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/);
        if(!getEmail.test($("#email").val())){
        $(".duEmail").text("Email 형식에 맞춰 입력해주세요");
        $('.duEmail').css("color","red"); 
    	}
        $.ajax({
            url:'/dupliEmailCheck', 
            type:'post', 
            data:{email:email},
            success:function(cnt){ 
				if(getEmail.test($("#email").val())){
	                if(cnt == 0){ 
	                    $(".duEmail").text("가입 가능한 Email입니다.");
	                    $('.duEmail').css("color","blue"); 
	                    
	                } else { 
	                    $(".duEmail").text("가입이 완료된 Email입니다.");
	                    $('.duEmail').css("color","red"); 
	                    $('#join').attr("disabled",true);
	                }
                }
            }
        });
        };        
 