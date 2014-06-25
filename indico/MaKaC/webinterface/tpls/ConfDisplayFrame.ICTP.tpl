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


    % if (organizers or sponsors or cosponsors) and (currentURL.split(confId)[1] in ['/','/overview']):
        <!-- Right menu -->
        <div class="conf_rightMenu">

            % if organizers:
            <ul class="organizers_box">
                <h3>Organizers</h3>
                <li>
                    ${organizers}
                </li>
            </ul>
            % endif  

            % if sponsors:
            <ul id="sponsors_box" class="sponsor_box">
                <h3>Sponsors</h3>
                % for sp in sponsors:
                <li>
                    <a href="${sp['url']}" target="_blank"><img src="data:image/jpg;base64,${sp['data']}" alt="${sp['title']}" title="${sp['title']}" /></a>                    
                </li>
                % endfor
            </ul>
            % endif  

            % if cosponsors:
            <ul id="cosponsors_box" class="sponsor_box">
                <h3>Co-sponsors</h3>
                % for cosp in cosponsors:
                <li>
                    <a href="${cosp['url']}" target="_blank"><img src="data:image/jpg;base64,${cosp['data']}" alt="${cosp['title']}" title="${cosp['title']}" /></a>                    
                </li>
                % endfor
            </ul>
            % endif

         
            
        </div>
    % endif  


    


    </div>
</div>
