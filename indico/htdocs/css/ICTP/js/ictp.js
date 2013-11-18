// IE misses trim functionality
if(typeof String.prototype.trim !== 'function') {
  String.prototype.trim = function() {
    return this.replace(/^\s+|\s+$/g, '');
  }
}

// WEBKIT is not a decent browser
jQuery.extend({
    __stringPrototype: {
      decodeASCII: function(s){
        s = this.s(s);
        var output = "";
        
        if(s != null && s.length > 0){
          for (i=0; i < s.length;)
          {
            // holds each letter (2 digits)
            var letter = "";
            letter = s.charAt(i) + s.charAt(i+1)
        
            // build the real email address
        
            output += String.fromCharCode(parseInt(letter,16));
            i += 2;
          }
        } 
        
        return output;
      },
      
      s: function(s) {
        if (s === '' || s) { return s; }
        if (this.str === '' || this.str) { return this.str; }
        return this;
      }
    },
    string: function(str) {
      if (str === String.prototype) {
        jQuery.extend(String.prototype, jQuery.__stringPrototype);
      } else {
        return jQuery.extend({ str: str }, jQuery.__stringPrototype);
      }
    }
  });

$(function(){   
  var deobfuscateEmails = function(context){
    var nodes = context == null? $("a.js_emailLink"): $("a.js_emailLink", context);
    nodes.each(function(e){
      var email = $(this).attr('href').match(/mailto:(.*)/i);
      if(email.length > 0) email = email[1];
      else email = "";
      var fragments = email.split("%at%");
      
      if(fragments != null && fragments[0] != null && fragments[1] != null){
        var decEmail = fragments[0] + "@" + fragments[1].replace("|", ".");
        var href = "mailto:" + decEmail + "?subject=ICTP website enquiry";
    
        // here it does not work: on IE $(this).text(decEmail);  
        $(this).attr('href', href);
        $(this).attr('title', "send an e-mail to "+ decEmail);
        $(this).text(decEmail);     // abracadabra!
      }
    });  
  };
  
  /* deobfuscate Emails */
  deobfuscateEmails();  
  
   /* column width fix*/
  /*
  columnStyle_single: 1 colonna
  columnStyle_double: 2 colonne fallback
  columnStyle_doubleWithLeft: 2 colonne con colonna sx
  columnStyle_doubleWithRight: 2 colonne con colonna dx
  columnStyle_triple: 3 colonne
  */
  if ($(".fixColumn_js_content").length > 0) {
      var columnsNumber = 1;
      var leftColExists = false;
      var rightColExists = false;
      if ($(".fixColumn_js_columnLeft").length > 0) {
          if ($(".fixColumn_js_columnLeft").children().length > 0) {
              columnsNumber++;
              leftColExists = true;
          } else {
              $(".fixColumn_js_columnLeft").hide();
          }

      }
      if ($(".fixColumn_js_columnRight").length > 0) {
          if ($(".fixColumn_js_columnRight").children().length > 0) {
              columnsNumber++;
              rightColExists = true;
          } else {
              $(".fixColumn_js_columnRight").hide();
          }
      }

      switch (columnsNumber) {
          case 1: $(".fixColumn_js_content").addClass("columnStyle_single"); break;
          case 2:
              var cssclass;
              if (leftColExists) cssclass = "columnStyle_doubleWithLeft";
              else if (rightColExists) cssclass = "columnStyle_doubleWithRight";
              else cssclass = "columnStyle_double";

              $(".fixColumn_js_content").addClass(cssclass);
              break;
          case 3: $(".fixColumn_js_content").addClass("columnStyle_triple"); break;
      }
  }
  
  /* toggler definition */ 
  if(typeof $.toggler != 'undefined'){   
    $.toggler({
      selector: ".toggler_filters_category",
      showText: "Show filter",
      hideText: "Close filter",
      effectTime: 500,
      hideByDefault: false
    });
    
    $.toggler({
      selector: ".toggler_quick_links",
      showText: "Show links",
      hideText: "Close links",
      useImage: false,
      imagePosition: "right",
      imageShown: "http://www.ictp.it/images/arrow_up.png",
      imageHidden: "http://www.ictp.it/images/arrow_bottom.png",    
      effectTime: 500
    }); 
    /*
    
    $.toggler({
      selector: "#thirdLevelMenu li.selected > a, #thirdLevelMenu li.selectedParent > a",
      showText: "Show links",
      hideText: "Close links",
      useImage: true,
      imagePosition: "left",
      imageShown: "/images/menuArrowBottom.png",
      imageHidden: "/images/menuArrowRight.png",    
      effectTime: 500,
      hideByDefault: false      
    });  
*/    
  }

  /* scrollers definition */
  /*if(typeof $.scroller != 'undefined'){
    
    $.scroller({
      autoScroll: true,
      selectorId: "js_scrollNews-",
      disabledNavClass: "last",
      fixBoxesHeight: 100,
      hideByDefault: false,
      transitionMethod: function(itemToHide, itemToShow, effectTime, cb){
        var area   = itemToHide.parents('.newsToolArea');
        area.css({
          position: 'relative',
          top: 0,
          left: 0,
          overflow: 'hidden',
          height: 100 + 'px',
          width: '100%'
        });
        var slider = itemToHide.parents('.newsToolSlide');
        slider.css({
          position: 'absolute',
          height: 1000
        });        
        
        slider.animate({
          top: -(itemToShow.outerHeight(true) * itemToShow.data('index')) + 'px',
          left: 0     
        }, effectTime, cb);
      }      
    });  
  }*/
	
	  if(typeof $('.newsToolArea').newsScroller != 'undefined'){
		  $('.newsToolArea').newsScroller({    
			outerContainerClass: 'newsToolArea',
			innerContainerClass: 'newsToolSlide',
			childrenClass: 'insideDiv',
			controls: true,
			prevControlClass: 'js_scrollNews-prev',
			nextControlClass: 'js_scrollNews-next',
			width: 134, //qualsiasi valore possibile tranne 'auto'
			scrollType: 'vertical', //valori possibili: 'horizontal', 'vertical',
			autoSlide: true,
			animationSpeedTime: 800,
			intervalSpeedTime: 5000,
			pauseOnHover: true
		  });
	  }
	
	  if(typeof $('.newArrivalsBoxContainer').newsScroller != 'undefined'){
		  $('.newArrivalsBoxContainer').newsScroller({
			outerContainerClass: 'newArrivalsOuterContainer',
			innerContainerClass: 'newArrivalsInnerContainer',
			childrenClass: 'insideNewArrival',
			controls: true,
			width: 235, //qualsiasi valore possibile tranne 'auto'
			scrollType: 'horizontal', //valori possibili: 'horizontal', 'vertical',
			autoSlide: true,
			animationSpeedTime: 800,
			intervalSpeedTime: 5000,
			pauseOnHover: true
		  });
	  }
  
  $('a.az').click(function(){
    var el = $(this);
    el.addClass('loading');
    $.ajax({
      url: 'http://www.ictp.it/a-z.aspx',
      type: 'get',
      context: document.body,
      success: function(data){
        $(this).append(data);   
        if(typeof $.toggler != 'undefined'){
          $.toggler({
            selector: ".az-wrap .toggler_az",
            showText: "Show pages",
            hideText: "Hide pages",
            effectTime: 200,
            hideByDefault: true
          }); 
        }
 
        $('.az-wrap a.close').click(function(){
          var height = $('.az-wrap').outerHeight(true) + 60;
          $('.az-wrap').animate({
            height: height + "px"
          }, 400, 'swing', function(){
            $(this).slideUp(200, function(){
              $(this).remove();
            });
          });
          return false;
        });
        
        $('.az-wrap').slideDown(500);
      },
      error: function(){
        alert('The page you requested is not available at the moment');
      },
      complete: function(){
        el.removeClass('loading');
      }
    });
    return false;
  });
  
  /* videos dialog */
  $("a.js_videoDialog").click(function(e){
    var vobj = $("#widget_video_object_" + $(this).attr('rel'));
    vobj.css({ textAlign: 'center' });
    vobj.dialog({
      minWidth: 550,
      minHeight: 440,
      modal: true
    });
  });
	
	

  
  /* widget navigation positioning */
  $(window).load(function(){
    $("div.widget a.btn").each(function(i, el){
      $(el).css({ "marginTop": ($(el).parent().outerHeight() / 2) -28 });
    }); 
    
    $(".widget_content_wrapper").css({
      'height': "100%"
    }); 
    
    /* image in content width fix */
    $(".img_in_content").each(function(){
      var img = $(".img_div img", $(this));
  
      if(img.length > 0){
  
        var imgW = img.outerWidth();
        $(this).width(imgW + 12);
      }
    });    
  });     
  
  /* clickable boxes */  
  $(document).on('click', '.clickable_box', function() {
    var linkEl = $(".clickable_box_link", $(this));
    if(linkEl.length > 0){
      var link = linkEl.attr("href");
	  
      if(linkEl != null && linkEl.length > 0){
        if(linkEl.attr("target") === "_blank") {
          window.open(linkEl.attr('href'),'_blank','');
        }
        else {
          window.location.href = link;
        }
      }
    }
  }); 
 
  /* cursor becomes a pointer hover a clickableBox*/ 
  $(document).on({
    mouseenter:
      function() { $(this).css({ "cursor": "pointer" }); }
   }, '.clickable_box');
	
	
  /* lightbox */
  $('.lightbox').each(function(i, el){
    var el = $(el);    
    // performs image preload
    var imgTitle = el.attr('title');
    var imgSrc = el.attr('href');
    
    var imgTag = $("<img/>").attr({src: imgSrc, title: imgTitle})
                            .css({ position: 'absolute', top: '-6666px', left: '-6666px'})
                            .appendTo('body');    
    
    // attach event handler
    el.click(function(){
      var imgTitle = el.attr('title');
      var imgSrc = el.attr('href');    
      
      $.Overlay.dialog("", { 
        width: imgTag.outerWidth(true) + 30, 
        height: imgTag.outerHeight(true) + 70,
        minWidth: '500px'
      }, function(dialog){
        dialog.append($("<h1/>").text(imgTitle));
        
        imgTag.clone(true, true).removeAttr('style').appendTo(dialog).wrap('<div style="text-align:center"></div>');
      });    
      return false;
    });
  });
  
  /* video dialog */
  $('.videoDialog_js').click(function(e){
    var id = $(this).attr('rel');
    
    $.ajax({
      type: 'get',
      url: 'http://www.ictp.it/video-dialog-service.aspx',
      data: { video: id },
      dataType: 'html',
      success: function(data){
        $.Overlay.dialog(data, {width: 600});
      }
    });
    return false;
  });
  

  
  
  /* homepage tabs */
  $('.tabs').each(function(i, wrap){
    wrap = $(wrap);
    var links = $('li .tabTitle', wrap);
    var tabs = $('.tab', wrap);
    tabs.hide();
    wrap.removeClass('tabs_noJs');
    var visible = $('<div/>').attr('class', 'tab-visible').appendTo(wrap);
    links.click(function(e){
      var el = $(this);
      if(el.parent('li').hasClass('current')) return false;
      
      var tab = $('.tab', el.parent('li'));    
      var children = visible.children();
      if(children.length > 0){
        children.fadeOut(250, function(){
          children.remove();
          links.parent('li').removeClass('current');
          el.parent('li').addClass('current');
          tab.clone(true, true).appendTo(visible).fadeIn(150);       
        });      
      }else{
        tab.clone(true, true).appendTo(visible).fadeIn(150);       
      }           
    });
    
    links.each(function(i, link){
      if(i == 0) {
        $(link).click();
        $(link).parent('li').addClass('current');
      }
    });    
  }); 
  

  
  /* search form methods */
  if(typeof searchEngineUrl == 'string'){   
    
    /* search form  */
    $("#js_searchString").keydown(function(e){
      var keyCode = (e.keyCode ? e.keyCode : e.which); 
      if(keyCode == 13){
        $("#js_searchButton").click();
        return false;        
      } 
    });
        
    $("#js_searchButton").click(function(e){
        var searchString = $("#js_searchString").val();
        if(searchString != null && searchString.trim().length > 0){
          window.location.href = searchPageUrl + "?search=" + encodeURIComponent($("#js_searchString").val());
        }else{
          alert("Please, search something.");
        }
      
        e.preventDefault();
        return false;              
    });
      
    $("#js_searchString").focusin(function(){
       if($(this).val().toLowerCase() == 'search...') $(this).val("");
    });  
      
    $("#js_searchString").focusout(function(){
       if($(this).val().length == 0) $(this).val("search...");
    });      
      
    // auto submit if search query has been passed by global search form
    if($("#js_searchString").val() != null && $("#js_searchString").val().length > 0 && !$("#js_searchButton").hasClass("js_redir")){
      $("#js_searchButton").click();
    }
  }  
});
    
// fixes webkit dialog positioning    
$(window).load(function(){
  if($.browser.webkit == true){

    $(".js_videoDialog").click(function(){
      $(".ui-dialog").each(function(){
        $(this).css({left: ($("body").outerWidth() - $(this).outerWidth()) / 2 });
      });
      return true;
    });
  }   
});

//subsite home quicklinks
$(document).on('click', '[rel = show-subsite-quicklinks-js]', function(e) {
  e.preventDefault();
  var quickLinksToShow = $('[rel = subsite-quicklinks-to-show-js]');
  quickLinksToShow.toggle("fast");
});

//reset initial value of input textarea field

$(document).on('click', '[rel = field-to-reset]', function(e) {
  var textModified = $(this).hasClass('field-js-modified');
  if(!textModified) {
    $(this).addClass('field-js-modified');
    this.value = '';
    //$(this).css('color','#333333');
  }
});

