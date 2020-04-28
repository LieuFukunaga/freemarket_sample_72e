$(function(){
  // const KEY = gon.payjp_key;
  $("button").click(function(e){
    e.preventDefault();
    // Payjp.setPublicKey(KEY);
    Payjp.setPublicKey("sk_test_d45723089aa3e8d410f3a255");
    var card = {
      cvc      : $("#cvc").val(),
      number   : $("#number").val(),
      exp_year : $("#exp_year").val(),
      exp_month: $("#exp_month").val()
    };
    Payjp.createToken(card, function(s, response) {
      if (response.error) {
        alert('トークン作成エラー')
      }else{
        $("#cvc").removeAttr("name");
        $("#number").removeAttr("name");
        $("#exp_year").removeAttr("name");
        $("#exp_month").removeAttr("name");
        var token = response.id;

        $("#charge-form").append($("#payjpToken").val(response.id));
        $("#charge-form").get(0).submit();
      }
    });
  })
})