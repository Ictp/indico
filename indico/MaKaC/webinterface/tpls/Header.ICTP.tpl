% if self_._rh.isMobile() and Config.getInstance().getMobileURL():
    <%include file="MobileDetection.tpl"/>
% endif

<%include file="Announcement.tpl"/>

<div class="pageHeader pageHeaderMainPage clearfix">





       


                    <div class="serviceMenuWrapper">
						  
						  <ul id="quick_links_list">
						  <li><a href="http://www.ictp.it/homepage.aspx" title="go to ICTP home page">Home</a></li><span class="separator">|</span>
						  <li><a href="http://library.ictp.it" title="ICTP Library">Marie Curie Library</a></li><span class="separator">|</span>
						  <li><a href="http://www.ictp.tv/" title="ICTP scientific contents and programs made available throughout the world via electronic, digital, satellite and other information and communication tools. ">ICTP.tv</a></li><span class="separator">|</span>
						  <li><a href="http://portal.ictp.it" title="For ICTP users">Intranet</a></li><span class="separator">|</span><li><a href="https://webmail.ictp.it/webmail/src/login.php?secure_login=yes" title="Email for ICTP staff">Webmail</a></li><span class="separator">|</span>
						  <li><a href="http://www.ictp.it/about-ictp/media-centre.aspx" title="Your source for the latest information from ICTP ">Media Centre</a></li>
						  </ul>
						  
					  </div>



        % if searchBox != '':
            ${ searchBox }
        % endif

        <!--
            set fixed height on anchor to assure that the height is
            corrected if the image cannot be retrieved (i.e. https problems) -->
        <div style="clear: both;">
            <a style="min-height: 107px;" href="${ urlHandlers.UHWelcome.getURL() }">
                <img class="headerLogo" src="/indico/css/ICTP/images/logo_ictp_v3.png" />
            </a>
        </div>
        
        <div class="headerLogosWrapper">
							  <a class="unesco_ft" href="http://www.unesco.org" title="external link">&nbsp;</a>
							  <a class="iaea_ft" href="http://www.iaea.org" title="external link">&nbsp;</a>
							  <div class="clearZero">&nbsp;</div>
						  </div>
        
        
        
 <%include file="SessionBar.tpl" args="dark=False"/>
    <div class="globalMenu">
    
        <ul>
            <li onmouseover="this.className = 'mouseover'" onmouseout="this.className = ''"><a href="${ urlHandlers.UHWelcome.getURL() }">${ _("Home") }</a></li>
            <li id="createEventMenu" onmouseover="this.className = 'mouseover'" onmouseout="this.className = ''"><span class="dropDownMenu">${ _("Create event") }</span></li>

            % if roomBooking:
                <li onmouseover="this.className = 'mouseover'" onmouseout="this.className = ''"><a href="${ urlHandlers.UHRoomBookingWelcome.getURL() }">${ _("Room booking") }</a></li>
            % endif

            % if len(adminItemList) == 1:
                <li onmouseover="this.className = 'mouseover'" onmouseout="this.className = ''"><a href="${ adminItemList[0]['url'] }">${ adminItemList[0]['text'] }</a></li>
            % elif len(adminItemList) > 1:
                <li id="administrationMenu" onmouseover="this.className = 'mouseover'" onmouseout="this.className = ''"><span class="dropDownMenu">${ _("Administration") }</span></li>
            % endif

            % if currentUser:
                <li onmouseover="this.className = 'mouseover'" onmouseout="this.className = ''"><a href="${ urlHandlers.UHUserDashboard.getURL(currentUser) }">${ _("My profile") }</a></li>
            % endif

            <li id="helpMenu"  onmouseover="this.className = 'mouseover'" onmouseout="this.className = ''"><span class="dropDownMenu">${ _("Help") }</span></li>
            <li style="display: none;" onmouseover="this.className = 'mouseover'" onmouseout="this.className = ''"><a href="${ urlHandlers.UHContact.getURL() }">Contact</a></li>
            <li style="display: none;" onmouseover="this.className = 'mouseover'" onmouseout="this.className = ''"><a href="${ urlHandlers.UHCategoryMap.getURL(categId=0) }">Site Map</a></li>
            <li style="display: none;" onmouseover="this.className = 'mouseover'" onmouseout="this.className = ''"><a href="${ urlHandlers.UHAbout.getURL() }">About Indico</a></li>

            <li onmouseover="this.className = 'mouseover'" onmouseout="this.className = ''" style="display: none;"><a href="urlHandlers.UHGetUserEventPage.getURL()">${ _("My Indico") }</a></li>
        </ul>
        
    </div>
    
    
    
    
</div>

<%
urlConference = urlHandlers.UHConferenceCreation.getURL(currentCategory)
urlConference.addParam("event_type","conference")

urlLecture = urlHandlers.UHConferenceCreation.getURL(currentCategory)
urlLecture.addParam("event_type","lecture")

urlMeeting = urlHandlers.UHConferenceCreation.getURL(currentCategory)
urlMeeting.addParam("event_type","meeting")
%>

<script type="text/javascript">
var createEventMenu = $E('createEventMenu');
var eventPopupMenu;
createEventMenu.observeClick(function(e) {
    var menuItems = {};
    menuItems["createLecture"] = {action: "${ urlLecture }" , display: '${ _("Create lecture") }'};
    menuItems["createMeeting"] = {action: "${ urlMeeting }", display: '${ _("Create meeting") }'};
    menuItems["createConference"] = {action: "${ urlConference }" , display: '${ _("Create conference") }'};

    //Create a new PopupMenu only if it has never been created before -> fix #679
    if(!eventPopupMenu){
        eventPopupMenu = new PopupMenu(menuItems, [createEventMenu], "globalMenuPopupList");
    }

    var pos = createEventMenu.getAbsolutePosition();
    eventPopupMenu.open(pos.x, pos.y + 30);

    var infoItems = {}; //List used to print additional help on the menu (MUST use the same keys as menuItems)
    infoItems["createLecture"] = "${ _("A <strong>lecture</strong> is a simple event to annouce a talk.<br/><strong>Features</strong>: poster creation, participants management,...") }";
    infoItems["createMeeting"] = "${ _("A <strong>meeting</strong> is an event that defines an agenda with many talks.<br/><strong>Features</strong>: timetable, minutes, poster creation, participants management,...") }";
    infoItems["createConference"] = "${ _("A <strong>conference</strong> is a complex event with features to manage the whole life cycle of a conference.<br/><strong>Features</strong>: call for abstracts, registration, e-payment, timetable, badges creation, paper reviewing,...") }";
    eventPopupMenu.drawInfoBubbles(infoItems);

    return false;
});

% if len(adminItemList) > 1:

    var administrationMenu = $E('administrationMenu');
    var administrationPopupMenu;
    administrationMenu.observeClick(function(e) {
        var menuItems = {};

        % for item in adminItemList:
        menuItems["${ item['id']}"] = {action: "${ item['url'] }", display: "${ item['text'] }"};
        % endfor
        //Create a new PopupMenu only if it has never been created before -> fix #679
        if(!administrationPopupMenu){
            administrationPopupMenu = new PopupMenu(menuItems, [administrationMenu], "globalMenuPopupList");
        }
        var pos = administrationMenu.getAbsolutePosition();
        administrationPopupMenu.open(pos.x, pos.y + 30);
        return false;
    });

% endif

var helpMenu = $E('helpMenu');
var helpPopupMenu;
helpMenu.observeClick(function(e) {
    var menuItems = {};

    menuItems['indicoHelp'] = {action: "${ urlHandlers.UHConferenceHelp.getURL() }", display: '${ _("Indico help") }'};
    menuItems['aboutIndico'] = {action: "${ urlHandlers.UHAbout.getURL() }", display: '${ _("About Indico") }'};
    menuItems['contactIndico'] = {action: "${ urlHandlers.UHContact.getURL() }", display: '${ _("Contact") }'};

    //Create a new PopupMenu only if it has never been created before-> fix #679
    if(!helpPopupMenu){
        helpPopupMenu = new PopupMenu(menuItems, [helpMenu], "globalMenuPopupList");
    }
    var pos = helpMenu.getAbsolutePosition();
    helpPopupMenu.open(pos.x, pos.y + 30);
    return false;
});

</script>

