<%
import urllib2

try:
    response = urllib2.urlopen("http://wwwnew.ictp.it/footercalendar.aspx")
    headers = response.info()
    data = response.read()
except:
    data = ''



#<img src="http://indico-int-2.ictp.it/css/ICTP/images/footer_test.png"  style="display:block;"  />
    
%>

 ${ data }



% if showSocial:
    <%include file="events/include/SocialIcons.tpl" args="dark=dark,url=shortURL,icalURL=icalURL,app_data=app_data"/>
% endif


