function machineExerciseCheck(exercise, select_id){
  // console.log(exercise);
  // console.log(exercise.split(" "));
  arr = exercise.split(" ");
  function resestMachine(){
    $('#session_exercise_machine_id').val(select_id);
  };
  if (arr[0].toLowerCase() == "machine" || arr[0].toLowerCase() == "plate-loaded"){
    $('#machine_input_new_session_exercise').show(500, function(){
      resestMachine();
    });
  } else {
    $('#machine_input_new_session_exercise').hide(500, function(){
      resestMachine();
    });
  }
};
