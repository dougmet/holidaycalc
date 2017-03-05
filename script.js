
$("form#longrun").submit(function(){
    $("#longrunout").hide();
    $.post("https://api.dougashton.net/pb/hols/longrun", $(this).serialize(), function(result){
        
        $("#longrunout").show();
        $("#maxw").html(result.window);
        
        ul = $("#lrdates");
        ul.html("");
        $.each(result.dates, function(prop, val) {
            $("<li>").text(val).appendTo(ul); // ?
        });
        
        //console.log(result);
    });
    return false;
});