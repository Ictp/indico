<%
if bgColorCode:
    bgColorStyle = """ style="background: #%s; border-color: #%s;" """%(bgColorCode, bgColorCode)
else:
    bgColorStyle = ""

if textColorCode:
    textColorStyle = """ style="color: #%s;" """%(textColorCode)
else:
    textColorStyle = ""
%>



<%
import urllib2
response = urllib2.urlopen("http://www.ictp.it/headercalendar.aspx")
headers = response.info()
data = response.read()
%>

<div class="conf clearfix" itemscope itemtype="http://schema.org/Event">
    <div class="confheader clearfix" ${ bgColorStyle }>

            ${ data }

        
        % if simpleTextAnnouncement:
            <div class="simpleTextAnnouncement">${ simpleTextAnnouncement }</div>
        % endif
    </div>

    
    
    
    
    <div id="confSectionsBox" class="clearfix">
    









<%namespace name="common" file="${context['INCLUDE']}/Common.tpl"/>

<div class="eventWrapper" itemscope itemtype="http://schema.org/Event">

    <%block name="meetingBody">
        <%include file="${INCLUDE}/IctpMeetingBody.tpl"/>
    </%block>
</div>

    


    </div>
</div>












