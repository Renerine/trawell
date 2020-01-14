/**
    * @author Mario Paone
    * this javascript remove an Ad
    * 
*/

/*$(document).ready(function(){
    $(".remove").click(function () {
        var idad = $(this).attr("id");
        alert("are you sure you want to eliminate this ad?")
        $.post("/agency/deleteAd", {id: idad});
            
        })
    });
    */

$(document).ready(function () {
    $(".remove").click(function () {
        var idad = $(this).attr("id");
        alert("are you sure you want to eliminate this ad?")
        $.ajax({
            type: 'POST',
            url: "/agency/deleteAd",
            data: { id: idad },
            async: false,
            success: function (data) {
                alert("Ad successfully removed");
                location.reload();
            },
            error: function (request, textStatus, errorThrown) {
                alert("Failed");
                
            }
        });
    })
});