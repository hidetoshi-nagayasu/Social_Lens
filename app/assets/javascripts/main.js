$(function() {

    $("#post_text").height(100); //init
    $("#post_text").css("lineHeight","20px"); //init

    $("#post_text").on("input",function(e){
        if(e.target.scrollHeight > e.target.offsetHeight){   
            $(e.target).height(e.target.scrollHeight);
        }else{          
            var lineHeight = Number($(e.target).css("lineHeight").split("px")[0]);
            while (true){
                $(e.target).height($(e.target).height() - lineHeight); 
                if(e.target.scrollHeight > e.target.offsetHeight){
                    $(e.target).height(e.target.scrollHeight);
                    break;
                }
            }
        }
    });

});