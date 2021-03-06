$.getScript(" ../js/serializeForm.js", function () { });

/**
	 * @author Ruggiero Gaetano
	 * the javascript allows for the add group functionality to be dealt asynchronously via 
     * JSON.
     *  */

$(document).ready(function () {

    /**
     * @author Ruggiero Gaetano
     * the function makes the ajax call to server to modify the clients data in database
     *  */
    $('#addGroup').submit(function (e) {
        e.preventDefault();
        var data = $('form').serializeFormJSON();
        var URL = $('form').attr("action");

        if (!$("#target .error").exists()) {
            $.ajax({
                type: "POST",
                dataType : "text",
                url: URL,           
                headers:{
                    'Accept' : 'application/json',
                    'Content-Type' : 'application/json'
                   },
                data:JSON.stringify(data),
                success: function (data) {
                    savedData= JSON.parse(data);
                    console.log(savedData);
                    alert("Gruppo aggiunto con successo, Complimenti!");
                    $( "input[name*='name']" ).val( "" );
                    $( "textarea[name*='description']" ).val("");
                    $( "select[name*='idItinerary']" ).val( "" );
                    $('#exampleModalCenter').modal('hide');
                    location.reload();                          

                }
            });
        }
    });
});