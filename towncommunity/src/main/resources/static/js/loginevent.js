$("#id").on('input', checkInput);
$("#password").on('input', checkInput);

function checkInput() {
  var idCheck = $("#id").val();   
  var passwordCheck = $("#password").val();  
  var btnLogin = $('.loginbtn');

  if (idCheck === '' || passwordCheck === '') {
    btnLogin.removeClass('on');
    btnLogin.attr("disabled", true);
  } else {
    btnLogin.addClass('on');
    btnLogin.attr("disabled", false);
  }
}
