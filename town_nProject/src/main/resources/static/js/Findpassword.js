var win; 

function Findpasswordopen() {
  win =window.open("/Findpassword", "PopupWin", "width=760,height=330");
 	win;
}

 function checkFindEmail(){
	 	
	 	var member_id= $('#id').val();
        var email = $('#email').val(); 
        var sendEmail = document.forms["sendEmail"];
        $.ajax({
            url:'/dupliFindEmailCheck', 
            type:'post', 
            data:{
				member_id:member_id,
				email:email
				},
            success:function(cnt){ 
	                if(cnt == 0){ 
						
	                    alert('ID와 이메일이 맞는지 확인해주세요');
	                }
	                else{
						$.ajax({
	            			type : 'post',
			            	url : '/FindpwSendEmail',
			            	data : {
			               		 email:email
			               		 },
		            		success : function(data){
								$('#password').val(data);
								
								sendEmail.submit();
					}
	        });
					}
                
            }
        });

    
        };        
 
