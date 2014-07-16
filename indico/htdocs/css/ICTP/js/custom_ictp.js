
// $(function(){   
//     $('#menuLink_timetable').find("a").text('Programme');
// });
    
  
$(function(){  

    $('#menuLink_timetable').find("a").text('Program');
    $('#menuLink_authorIndex').find("a").text('Speakers');

    // search for APPLICATION FORM 
    var af = $('a:contains("application form")').attr('href');
    if (af) {
        $("#menuLink_authorIndex").append('<li id="menuLink_applyHere" class="menuConfTitle"><a href="'+af+'">Apply here</a></li>');
    }
    
    // search for PARTICIPANT LIST
    var pl = $('a:contains("participant")').attr('href');
    if (pl) {
        $("#menuLink_authorIndex").append('<li id="menuLink_participantsList" class="menuConfTitle"><a href="'+pl+'">Participants list</a></li>');
    }
    
    // add PRACTICAL INFO
    $("ul#outer").append('<li id="menuLink_Practical info" class="menuConfTitle"><a href="http://www.ictp.it/visit-ictp/pre-arrival-guide.aspx" target="_blank">Practical info</a></li>');

});  
  
  
$(window).load(function(){
});

