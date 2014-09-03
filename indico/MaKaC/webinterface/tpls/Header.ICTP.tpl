% if self_._rh.isMobile() and Config.getInstance().getMobileURL():
    <%include file="MobileDetection.tpl"/>
% endif

<%include file="Announcement.tpl"/>

<div class="pageHeader pageHeaderMainPage clearfix">





       

  
 <%include file="SessionBar.ICTP.tpl" args="dark=False"/>
    
    
    
    
    
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



</script>

