//= require jquery3
//= require rails-ujs
//= require_tree .
//= require local-time

$(document).ready(function() {
  // console.log($(".form-group-invalid"));

  // If a form has an error, make sure children elements are visible
  $(".form-group-invalid").each( function(){
    $(this).parent().show();
    $(this).children("select").val(null);
  });

  machineExerciseCheck($("#session_set_exercise_id option:selected").text());
  console.log($("#session_set_exercise_id option:selected").text());

});
