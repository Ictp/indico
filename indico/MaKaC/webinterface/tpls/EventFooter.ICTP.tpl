<%
import urllib2
response = urllib2.urlopen("http://www.ictp.it/footercalendar.aspx")
headers = response.info()
data = response.read()
%>

${ data }



% if showSocial:
    <%include file="events/include/SocialIcons.tpl" args="dark=dark,url=shortURL,icalURL=icalURL,app_data=app_data"/>
% endif


