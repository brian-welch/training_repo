//= require jquery3
//= require rails-ujs
//= require_tree .
//= require local-time

$(document).ready(function() {
  // console.log($(".form-group-invalid"));

  // If a form has an error, make sure children elements are visible
  $(".form-group-invalid").each(function(){
    $(this).parent().show();
    $(this).children("select").val(null);
  });

  machineExerciseCheck($("#session_set_exercise_id option:selected").text());
  console.log($("#session_set_exercise_id option:selected").text());

  $(".email_anchor_link").hover(function(){
    console.log('test');
    var a = 'mailto: ', b = 'admin@', c = 'trainingrepo.com';
    $(this).attr('href', a + b + c);
  });

  $(".exercise_toggle").on('click', function(){
    // console.log(this.dataset.buttonSetGroup);
    // console.log($("div[data-button-set-group=" + this.dataset.buttonSetGroup + "]"));
    $("div[data-button-set-group=" + this.dataset.buttonSetGroup + "]").each(function(){
      $(this).toggleClass("active");
    })
    $("div[data-content-set-group=" + this.dataset.buttonSetGroup + "]").toggle();
  });

  $(".link_to_training_session").hover(function(){
    $("#month-" + this.dataset.monthYear).html(this.dataset.seshStrat);
  });
  $(".link_to_training_session").mouseout(function(){
    $("#month-" + this.dataset.monthYear).html(" &nbsp;");
  });


});
