function machineExerciseCheckId(){

  let keyword = $("#session_set_exercise_id option:selected").text().split(" ").pop();

  function resetMachine(){
    $('#session_set_machine_id').val(null);
  };
  function resetPulley(){
    $('#session_set_pulley_count').val(1);
  };

  if (keyword.toLowerCase() == "machine" || keyword.toLowerCase() == "plate-loaded"){
    $('#machine_input_new_session_set').show(500);
    $('#pulley_input_new_session_set').hide(500);
    resetPulley();
  } else if (keyword.toLowerCase() == "cable" || keyword.toLowerCase() == "crossover") {
    $('#machine_input_new_session_set').hide(500);
    $('#pulley_input_new_session_set').show(500);
    resetMachine();
  } else {
    $('#pulley_input_new_session_set').hide(500);
    $('#machine_input_new_session_set').hide(500);
      resetMachine();
      resetPulley();
  }
};

function machineExerciseCheckName(){

  let keyword = $("#session_set_exercise_name").val().split(" ").pop();

  function resetMachine(){
    $('#session_set_machine_id').val(null);
  };
  function resetPulley(){
    $('#session_set_pulley_count').val(1);
  };

  if (keyword.toLowerCase() == "machine" || keyword.toLowerCase() == "plate-loaded"){
    $('#machine_input_new_session_set').show(500);
    $('#pulley_input_new_session_set').hide(500);
    resetPulley();
  } else if (keyword.toLowerCase() == "cable" || keyword.toLowerCase() == "crossover") {
    $('#machine_input_new_session_set').hide(500);
    $('#pulley_input_new_session_set').show(500);
    resetMachine();
  } else {
    $('#pulley_input_new_session_set').hide(500);
    $('#machine_input_new_session_set').hide(500);
      resetMachine();
      resetPulley();
  }
};
