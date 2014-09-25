// IE misses trim functionality
if(typeof String.prototype.trim !== 'function') {
  String.prototype.trim = function() {
    return this.replace(/^\s+|\s+$/g, '');
  }
}

var screenMaxXxsSize = 450;
var screenMaxXsSize = 767;


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
  





/* START PROMOSCIENCE */


    $('body, html').css('overflow', 'hidden');
    var windowSize = $(window).width();
    $('body, html').css('overflow', 'visible');

    var researchSections = $('.researchSectionItem');
    var visitIctpSections = $('.visitIctpItem');
    var nextDeadlinesSections = $('.nextDeadlineItem');
    var desktopMenuColumns = $('.five-columns-menu');

    /* RESPONSIVE MENU*/
    $('.expandableMenu').click(function () {
        var a = $(this);
       
        $('.expandableMenu').each(function () {
            var b = $(this);
            if (b.text() != a.text()) {
                $(this).closest(".nav-responsive").children(".insideMenuContainer").hide();
                $(this).children("i").attr('class', 'fa fa-caret-right');
            }            
        });
        
        $(this).closest(".nav-responsive").children(".insideMenuContainer").toggle(0, function () {

            if ($(this).attr('style') == 'display: none;') {
                a.children("i").attr('class', 'fa fa-caret-right');
            }
            else {
                a.children("i").attr('class', 'fa fa-caret-down');
            }            
        });
        normalizeHeight(researchSections, true);
    });

    var navigationBar = $(".main-menu");
    var menuItems = navigationBar.find('.dropdown');

    menuItems.click(function () {
        var menuColumns = $(this).children('div.dropdown-menu').children();
        var containerDropDown = $(this).children('div.dropdown-menu');
        var menuWidth = $(this).width() - 3;

        containerDropDown.children().width(menuWidth);
        menuColumns.height('auto');
        if (($(this).width() - 2) * menuColumns.length < ($(window).width() - 90)){
            containerDropDown.width(($(this).width() - 2) * menuColumns.length);
            setTimeout(function () {
                var maxHeight = -1;
                menuColumns.each(function () {
                    $(this).height() > maxHeight ? maxHeight = $(this).height() : maxHeight;
                });
                menuColumns.height(maxHeight);
            }, 100);
            if (menuColumns.length > 1)
                containerDropDown.css('right', -1 * menuWidth - 2 + 'px');
        }
        else {
            var availableColumns = (($(window).width() - 90) / menuWidth);        
            
            var menuWidth = $(this).width() - 2;
            if (menuColumns.length > 1)
                containerDropDown.css('right', -1 * menuWidth + 80 + 'px');
        }
        containerDropDown.width($('.mainContainer').width());
    });

    var responsiveMenuButton = $('.responsiveMenuButton');
    var smallResponsiveMenuButton = $("[data-ps='button-menu']");

    responsiveMenuButton.click(function () {
        var button = $(this);
        if (button.hasClass('openMenu')) {
            button.removeClass('openMenu');
            $('.hidden-responsive-menu').removeClass('openedMenu');

            $('.expandableMenu').each(function () { 
                $(this).closest(".nav-responsive").children(".insideMenuContainer").hide();
                $(this).children("i").attr('class', 'fa fa-caret-right');
            });
        }
        else {
            button.addClass('openMenu');
            $('.hidden-responsive-menu').addClass('openedMenu');

        }
    });

    smallResponsiveMenuButton.click(function () {
        $('html, body').animate({ scrollTop: 0 }, 0);
        responsiveMenuButton.click();
    });

    /* END RESPONSIVE MENU*/

    /* Desktop Menu*/

    $("[data-ps-menu='menu-item']").click(function () {
        var id = this.id;        
        var dropdownMenu = $("[data-ps-dropdown='" + id + "']");

        $("[data-ps-menu='menu-dropdown']").each(function () {
            if ($(this).attr('data-ps-dropdown') != dropdownMenu.attr('data-ps-dropdown')) {
                $(this).hide();
            }
        });
        $("[data-ps-menu='menu-item']").each(function () {
            if ($(this).id != id) {
                $(this).removeClass('menu-item-active');
                $(this).children().children().removeClass('fa-sort-up');
                $(this).children().children().addClass('fa-sort-down');
            }
        });

        if (dropdownMenu.is(':hidden')) {            
            dropdownMenu.show();
            $(this).addClass('menu-item-active');
            normalizeHeight(desktopMenuColumns);
            normalizeHeight(researchSections, true);
            $(this).children().children().removeClass('fa-sort-down');
            $(this).children().children().addClass('fa-sort-up');

        }
        else {
            dropdownMenu.hide();
            $(this).removeClass('menu-item-active');
            $(this).children().children().removeClass('fa-sort-up');
            $(this).children().children().addClass('fa-sort-down');
        }

    });

    /* END Desktop Menu*/

    normalizeHeight(researchSections, true);
    normalizeHeight(visitIctpSections, true);
    normalizeHeight(nextDeadlinesSections, true);
    
    $(window).resize(function () {        
        windowSize = $(window).width();

        normalizeHeight(researchSections, true);
        normalizeHeight(visitIctpSections, true);
        normalizeHeight(nextDeadlinesSections, true);
        normalizeHeight(desktopMenuColumns);
        resetCollapsedPanel();
    });

    $(window).on("orientationchange", function () {
        windowSize = $(window).width();

        normalizeHeight(researchSections, true);
        normalizeHeight(visitIctpSections, true);
        normalizeHeight(nextDeadlinesSections, true);
        normalizeHeight(desktopMenuColumns);
        resetCollapsedPanel();
    });

    $('.carousel').on('slid.bs.carousel', function () {
        normalizeHeight(nextDeadlinesSections, true);
    })

    function resetCollapsedPanel() {
        if (windowSize > screenMaxXsSize) {
            $('.uncollapse-sm').attr('style', function (i, style) {
                return style.replace(/height[^;]+;?/g, '');
            });
        }
    }

    function normalizeHeight(sections, xsResize){
        if (sections.length > 0 && windowSize > screenMaxXsSize) {
            var maxHeight = -1;
            sections.css('height', 'auto');
            sections.each(function () {
                $(this).height() > maxHeight ? maxHeight = $(this).height() : maxHeight;
            });
            sections.height(maxHeight);
        }
        else if (sections.length > 0 && windowSize <= screenMaxXsSize && windowSize >= screenMaxXxsSize && xsResize) {
            var maxHeight = -1;
            sections.css('height', 'auto');
            sections.each(function (i) {
                if (i % 2 == 0) {
                    maxHeight = -1;
                    $(this).height() > maxHeight ? maxHeight = $(this).height() : maxHeight;
                }
                else {
                    $(this).height() > maxHeight ? maxHeight = $(this).height() : maxHeight;
                    $(sections[i-1]).height(maxHeight);
                    $(sections[i]).height(maxHeight);
                }
            });
            //sections.height(maxHeight);
        }
        else if (sections.length > 0 && windowSize < screenMaxXxsSize) {
            sections.css('height', 'auto');
        }
    }

    var isQuicklinksExpanded = false;
    var isSearchExpanded = false;

    $('#expandQuicklinksMenu').click(function () {        
        $('.quickLinksMenu').toggle();

        if ($(this).parent().hasClass('quicklinksActive')) {
            $(this).parent().removeClass('quicklinksActive');
            isQuicklinksExpanded = false;
        }
        else {
            //if (isSearchExpanded == true) {
            //    $('#expandSearchMenu').trigger("click");
            //}
            $(this).parent().addClass('quicklinksActive');
            isQuicklinksExpanded = true;
            
        }
    });

    

    $(".carousel").swiperight(function () {
        $(this).carousel('prev');
    });
    $(".carousel").swipeleft(function () {
        $(this).carousel('next');
    });


    /* google search*/

    var inputSearch = $("[data-ps-type=ps-google-input]");
    var inputSearchMobile = $("[data-ps-type=ps-google-input-mobile]");
    var searchPage = $("[data-ps-type=ps-google-input]").attr("data-ps-search-link");

    $('#expandSearchMenu').click(function (e) {
        
        if (inputSearch.val().length > 0 && $('.searchMenuContainer').is(':visible'))
            location.href = searchPage + "?search=" + inputSearch.val();
        else
            $('li.searchMenuContainer').toggle('fast');
    });

    $('[data-ps-type=ps-google-search-mobile]').click(function (e) {

        if (inputSearchMobile.val().length > 0)
            location.href = searchPage + "?search=" + inputSearch.val();
    });

    $("[data-ps-type=ps-google-input]").keyup(function (e) {
        if (event.which == 13) {
            event.preventDefault();            
            if (inputSearch.length > 0)
                location.href = searchPage + "?search=" + inputSearch.val();
        }
    });

    $("[data-ps-type=ps-google-input-mobile]").keyup(function (e) {
        if (event.which == 13) {
            event.preventDefault();
            if (inputSearchMobile.length > 0)
                location.href = searchPage + "?search=" + inputSearchMobile.val();
        }
    });

    /* END google search*/

    /* leftColumn hide*/

    if ($('[data-ps-type=left-column]').length > 0 && $("[data-ps-type=left-column]").children().length == 0) {
        $('[data-ps-type=left-column]').hide();
        $('[data-ps-type=right-column]').removeClass();
        $('[data-ps-type=right-column]').addClass('col-xs-12 containerRightColumn borderless paddingZero');
    }
    /* end leftColum Hide*/

    /* standard page collapsible content*/
    $("[data-ps-type='collapsible-button']").click(function (e) {
        e.preventDefault();
        $("[data-ps-type='collapsible-content']").toggle();
        if ($("[data-ps-type='collapsible-content']").is(":visible"))
            $(this).hide();
    });
    /* end standard page collapsible content*/

/* END PROMOSCIENCE */





  

        $('.searchButton').click(function() {
                $('#searchBoxForm').submit();
        })

  
  
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
  }


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
  

  

  
  
  
    $('#menuLink_timetable').find("a").text('Programme');
    $('#menuLink_authorIndex').find("a").text('Speakers');
    $('#menuLink_authorIndex').find("a").attr("href", "speakers")

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

    // add PRACTICAL INFO if no section "outside Trieste"
    var section = $('body').attr("section");
    if (section != '2l132') {
        $("ul#outer").append('<li id="menuLink_Practical info" class="menuConfTitle"><a href="http://www.ictp.it/visit-ictp/pre-arrival-guide.aspx" target="_blank">Practical info</a></li>');
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

