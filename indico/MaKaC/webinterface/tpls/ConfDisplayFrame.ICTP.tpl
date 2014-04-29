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
    ${ menu }
    ${ body }

    </div>
</div>
