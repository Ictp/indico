<%
import urllib2
response = urllib2.urlopen("http://ictp3.promoscience.com/footercalendar.aspx")
headers = response.info()
data = response.read()
#<img src="http://indico-int-2.ictp.it/css/ICTP/images/footer_test.png"  style="display:block;"  />
%>

 ${ data }



% if showSocial:
    <%include file="events/include/SocialIcons.tpl" args="dark=dark,url=shortURL,icalURL=icalURL,app_data=app_data"/>
% endif


