//= require jquery3
//= require rails-ujs
//= require_tree .
//= require local-time
//= require jquery.ui.all

$(document).ready(function() {
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
    $("div[data-button-set-group=" + this.dataset.buttonSetGroup + "]").each(function(){
      $(this).toggleClass("active");
    })
    $("div[data-content-set-group=" + this.dataset.buttonSetGroup + "]").toggle();
  });

  // hover functionality to show what the session strategy was on a given day in the training session index calendar
  $(".link_to_training_session").hover(function(){
    $("#month-" + this.dataset.monthYear).html(this.dataset.seshStrat);
    $(this).parent().parent().addClass('day_hover');
  });
  $(".link_to_training_session").mouseout(function(){
    $("#month-" + this.dataset.monthYear).html(" &nbsp;");
    $(this).parent().parent().removeClass('day_hover');
  });



});
