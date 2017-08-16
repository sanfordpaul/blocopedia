$(document).ready(function() {

    $(".add_field_button").click(function(e){ //on add input button click
        e.preventDefault();
        $('.input_fields_wrap').append('<div><input type="text" name="email[]" placeholder="Enter email address"/></div>'); //add input box

    });


});
