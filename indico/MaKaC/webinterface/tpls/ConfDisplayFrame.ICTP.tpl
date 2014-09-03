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

<div class="conf" itemscope itemtype="http://schema.org/Event">
    <div class="confheader" ${ bgColorStyle }>

            

        
        % if simpleTextAnnouncement:
            <div class="simpleTextAnnouncement">${ simpleTextAnnouncement }</div>
        % endif


    
    
    
    
    <div id="confSectionsBox" class="clearfix">

    ${ menu }

    ${ body }


    % if (organizers or sponsors or cosponsors) and (currentURL.split(confId)[1] in ['/','/overview']):
        <!-- Right menu -->
        <div class="conf_rightMenu">

            % if organizers:
            <div class="type1_box">
                <h3>Organizers</h3>
                <div class="type1_box_content">
                    ${organizers}
                </div>
            </div>
            % endif  

            % if sponsors:
            <div id="sponsors_box" class="type1_box">
                <h3>Sponsors</h3>
                <div class="type1_box_content">
                <ul>
                % for sp in sponsors:
                <li>
                    % if sp['url']:
                        <a href="${sp['url']}" target="_blank">
                    % endif
                    % if sp['data']:
                            <img src="data:image/jpg;base64,${sp['data']}" alt="${sp['title']}" title="${sp['title']}" />
                    % else:
                        <span>${sp['title']}</span>
                    % endif
                    % if sp['url']:
                        </a>  
                    % endif                  
                </li>
                % endfor
                </ul>
                </div>
            </div>
            % endif  

            % if cosponsors:
            <div id="cosponsor_box" class="type1_box">
                <h3>Co-sponsors</h3>
                <div class="type1_box_content">
                <ul>
                % for cosp in cosponsors:
                <li>
                    % if cosp['url']:
                        <a href="${cosp['url']}" target="_blank">
                    % endif
                    % if cosp['data']:
                            <img src="data:image/jpg;base64,${cosp['data']}" alt="${cosp['title']}" title="${cosp['title']}" />
                    % else:
                        <span>${cosp['title']}</span>
                    % endif
                    % if cosp['url']:
                        </a>  
                    % endif                  
                </li>
                % endfor
                </ul>
                </div>
            </div>
            % endif

         
            
        </div>
    % endif  


    


    </div>
    
    
    </div>    
    
</div>
