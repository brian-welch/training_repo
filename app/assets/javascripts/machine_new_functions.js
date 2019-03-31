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

function namingConventionInfo(){
  alert("\n\nPlease start by naming the series name of the machine;\nmanufacturers should have this written somewhere on the machine.\n\n\n\tThen a hyphen.\n\n\n\t\tThen the specific name of the movement as listed on the machine;\n\t\tor the general description of the movement if there isn't a name.\n\n")
}
