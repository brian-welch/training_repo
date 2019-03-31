function machineExerciseCheck(exercise, select_id){
  // console.log(exercise);
  // console.log(exercise.split(" "));
  arr = exercise.split(" ");
  function resestMachine(){
    $('#session_set_machine_id').val(select_id);
  };
  function zeroOutMachine(){
    $('#session_set_machine_id').val(null);
  };

  if (arr[0].toLowerCase() == "machine" || arr[0].toLowerCase() == "plate-loaded"){
    $('#machine_input_new_session_set').show(500);
    zeroOutMachine();
  } else {
    $('#machine_input_new_session_set').hide(500, function(){
      resestMachine();
    });
  }
};
