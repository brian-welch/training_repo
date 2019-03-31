function check_machine_name(allMachinesFromBrand,name) {
  console.log(allMachinesFromBrand);
  console.log(name);
};

$(document).ready(function() {
  console.log($(".form-group-invalid"));
  $(".form-group-invalid").each( function(){
    $(this).parent().show();
    $(this).children("select").val(null);
  });
});
