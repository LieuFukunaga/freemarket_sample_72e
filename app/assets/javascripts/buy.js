$(function(){
  // const KEY = gon.payjp_key;
  $("button").click(function(e){
    e.preventDefault();
    // Payjp.setPublicKey(KEY);
    Payjp.setPublicKey("pk_test_ade9943c4f26730713dc9dfd");
    var card = {
      cvc      : $("#cvc").val(),
      number   : $("#number").val(),
      exp_year : $("#exp_year").val(),
      exp_month: $("#exp_month").val()
    };
    Payjp.createToken(card, function(s, response) {
      $("#charge-form").append($("#payjpToken").val(response.id));
      $("#charge-form").get(0).submit();
    });
  })
})