$("#id").on('input', checkInput);
$("#id").on('keyup', checkInput);
$("#name").on('input', checkInput);
$("#phone").on('input', checkInput);
$("#num").on('input', checkInput);
$("#email").on('input', checkInput);
$("#email").on('keyup', checkInput);
$("#pw").on('input', checkInput);
$("#pw2").on('input', checkInput);




function checkInput() {
	var idCheck =$("#id").val();
  var nameCheck = $("#name").val();   
  var phoneCheck =$("#phone").val();
  var numCheck =$("#num").val();
  var mailCheck = $("#mail").val();
  var addressCheck =$("#address-1").val();
  var passwordCheck = $("#pw").val();   
  var passwordCheck2 = $("#pw2").val();
  var join = $('.join');
  var checkid = $('.duID').text();
  var checkEmail = $('.duEmail').text();

    if ((idCheck===''||addressCheck==='')||(nameCheck==='' || phoneCheck==='' )||((mailCheck === '' || passwordCheck === '' )||(passwordCheck2 === ''|| numCheck === ''))) {
    join.removeClass('on');
    join.attr("disabled", true);
  } else {
    join.addClass('on');
    join.attr("disabled", false);
  }
  	if (checkid ==="가입이 완료된 ID입니다." || checkEmail ==="가입이 완료된 Email입니다."){
	join.removeClass('on');
    join.attr("disabled", true);
  }
}

