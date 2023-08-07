
function findAddr(){
	new daum.Postcode({
        oncomplete: function(data) {    
            var jibunAddr = data.jibunAddress; 
            if(jibunAddr !== ''){ 
               document.getElementById("address-1").value= data.sido+"시 "+data.sigungu+" "+data.bname;
            }
        }
    }).open();
}