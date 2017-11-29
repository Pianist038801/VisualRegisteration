$(function () {

  $( "#customer-select" ).select2({
    tags: true,
    insertTag: function(data, tag){
      tag.text = "Add New: '" + tag.text + "'";
      data.push(tag);
    }
  });

  $( "#project-select" ).select2({
    placeholder: "Project(or Create New)",
    tags: true,
    insertTag: function(data, tag){
      tag.text = "Add New: '" + tag.text + "'";
      data.push(tag);
    }
  });

  $( "#task-select" ).select2({
    placeholder: "Project(or Create New)",
    tags: true,
    insertTag: function(data, tag){
      tag.text = "Add New: '" + tag.text + "'";
      data.push(tag);
    }
  });


  $( "#requisition-select-supplier" ).select2({
      placeholder: "Task(or Create New)"
  });



  $("#customer-select").on("select2:select", function (event) {
    var value = $(event.currentTarget).find("option:selected").val();
    var text = $(event.currentTarget).find("option:selected").text();
    console.log(value);
    $('.customer_id').val(value);
    $('.project_id').val(value);
    $('.task_id').val(value);
    $('#add_new_customer').attr("href", "/customers/new?name=" + text )
    if (value == text) {
      $('#add_new_customer').click();
    }
  });

  $("#project-select").on("select2:select", function (event) {
    var value = $(event.currentTarget).find("option:selected").val();
    var text = $(event.currentTarget).find("option:selected").text();

    console.log(value);
    $('.customer_id').val(value);
    $('.project_id').val(value);
    $('.task_id').val(value);
     $('#add_new_project').attr("href", "/projects/new?name=" + text )
     if (value == text) {
        $('#add_new_project').click();
      }
  });


  $("#task-select").on("select2:select", function (event) {
    var value = $(event.currentTarget).find("option:selected").val();
    var text = $(event.currentTarget).find("option:selected").text();
    console.log(value);
    $('.customer_id').val(value);
    $('.project_id').val(value);
    $('.task_id').val(value);
     $('#add_new_task').attr("href", "/tasks/new?name=" + text )
      if (value == text) {
        $('#add_new_task').click();
      }
  });



    $('.time').datetimepicker({
      format: 'HH:mm'
    });
    $('.datepicker').datetimepicker();

    $(document).on('dp.change', 'input#time_to_input', function() {
       var time_from = $("input#time_from_input").val();
       var time_to = $("input#time_to_input").val();
       var diff = ( new Date("1970-1-1 " + time_to) - new Date("1970-1-1 " + time_from) ) / 1000 / 60 / 60;  

       $("input#amount").val(diff)
    });
});

$(function(){
  
  $("#geocomplete_location_from").geocomplete()
    .bind("geocode:result", function(event, result){
      $.log("Result: " + result.formatted_address);
    })
    .bind("geocode:error", function(event, status){
      $.log("ERROR: " + status);
    })
    .bind("geocode:multiple", function(event, results){
      $.log("Multiple: " + results.length + " results found");
    });      
       

  $("#geocomplete_destination_to").geocomplete()
    .bind("geocode:result", function(event, result){
      $.log("Result: " + result.formatted_address);
    })
    .bind("geocode:error", function(event, status){
      $.log("ERROR: " + status);
    })
    .bind("geocode:multiple", function(event, results){
      $.log("Multiple: " + results.length + " results found");
    }); 
 
});

$(function () {

  $( ".task-select-supplier" ).select2({
      'placeholder': "Task(or Create New)"
  });

  $('#submit-btn').click(function(){
    $('#create-line-form').submit();
  });
  $("#create-line-form").validationEngine();
});

