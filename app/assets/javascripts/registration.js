$(document).on('turbolinks:load', function() {
  $( "#number_field" ).hide();
  $( "#user_company_attributes_registered" ).change(function() {
    $( "#company_field" ).toggle("slow");
    $( "#number_field" ).toggle("slow");
  });
});
