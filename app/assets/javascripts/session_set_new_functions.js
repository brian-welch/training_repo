function machineExerciseCheck(){ //, select_id){

  // console.log(exercise);
  // console.log(exercise.split(" "));
  let keyword = $("#session_set_exercise_id option:selected").text().split(" ")[0];
  // function resestMachine(){
  //   $('#session_set_machine_id').val(select_id);
  // };
  function resetMachinePulley(){
    $('#session_set_machine_id').val(null);
    $('#session_set_pulley_count').val(1);
  };

  if (keyword.toLowerCase() == "machine" || keyword.toLowerCase() == "plate-loaded"){
    $('#machine_input_new_session_set').show(500);
    $('#pulley_input_new_session_set').hide(500);
    resetMachinePulley();
  } else if (keyword.toLowerCase() == "cable" || keyword.toLowerCase() == "crossover") {
    $('#machine_input_new_session_set').hide(500);
    $('#pulley_input_new_session_set').show(500);
    resetMachinePulley();
  } else {
    $('#pulley_input_new_session_set').hide(500);
    $('#machine_input_new_session_set').hide(500);
      resetMachinePulley();
  }
};
