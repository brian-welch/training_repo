function getSessionStrategyInfo(array) {
  let desc_array = array[1];
  let temp = "";
  desc_array.forEach(function(e) {
    temp += "<li>" + e + "</li>";
  });
  $("#session_strategy_info_box").html(temp);
  $("#session_strategy_info_button").html("What is '" + array[0] + "'?");
  $(".reveal_caret").hide();

};

