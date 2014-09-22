<!DOCTYPE html>

<% baseUrl = baseurl if baseurl else "static" %>

<html xmlns:fb="http://ogp.me/ns/fb#" xmlns:og="http://opengraph.org/schema/">
    <head>
        <title>${ page._getTitle() }${ area }</title>
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="author" content=”Giorgio Pieretti, pieretti@ictp.it”>
        <link rel="shortcut icon" type="image/x-icon" href="${ systemIcon('addressBarIcon') }">

        <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
        <meta content="${self_._rh.csrf_token}" name="csrf-token" id="csrf-token"/>

% if social.get('facebook', {}).get('appId', None):
        <meta property="fb:app_id" content="${social['facebook']['appId']}"/>
% endif

% if analyticsActive and analyticsCodeLocation == "head":
        ${analyticsCode}
% endif

% if baseUrl == 'static':
        <script type="text/javascript">
        window.indicoOfflineSite = true;
        </script>
% endif

        <script type="text/javascript">
                var TextRoot = "${ baseUrl }/js/indico/i18n/";
                var ScriptRoot = "${ baseUrl }/js/";
        </script>

        <!-- Indico specific -->
        ${ page._getJavaScriptInclude(str(urlHandlers.UHJSVars.getURL())) } <!-- Indico Variables -->

        <!-- Page Specific JS files-->
        % for JSFile in extraJSFiles:
            ${ page._getJavaScriptInclude(JSFile) }
        % endfor

        <!--[if (gte IE 6)&(lte IE 8)]>
        % for JSFile in assets["ie_compatibility"].urls():
            ${'<script src="'+ baseurl + JSFile +'" type="text/javascript"></script>\n'}
        % endfor
        <![endif]-->

    <script type="text/javascript">
      var currentLanguage = '${ language }';
      loadDictionary(currentLanguage);
    </script>

        <!-- Page Specific CSS files-->
        % for cssFile in extraCSS:
            <link rel="stylesheet" type="text/css" href="${cssFile}">
        % endfor
        

        <!-- Page Specific, directly inserted Javascript -->
        <script type="text/javascript">
            ${ "\n\n".join(extraJS) }
        </script>

        <!-- Indico page-wide global JS variables -->
        <script type="text/javascript">
        <% user = page._rh.getAW().getUser() %>
        % if user:
            IndicoGlobalVars.isUserAuthenticated = true;
            IndicoGlobalVars.userData = ${ jsonEncode(page._getJavaScriptUserData()) };
        % else:
            IndicoGlobalVars.isUserAuthenticated = false;
        % endif
        </script>

        <!-- Other Page Specific -->
        ${ page._getHeadContent() }
        
        
        
        <!-- ICTP specific -->
        <link rel="stylesheet" type="text/css" href="/css/ICTP/css/Default.css" />
        <link rel="stylesheet" href="/css/ICTP/css/printer.css" type="text/css" media="print" />        

        <link rel="stylesheet" type="text/css" href="http://wwwnew.ictp.it/css/bootstrap.min.css" />
        <link rel="stylesheet" type="text/css" href="http://wwwnew.ictp.it/css/bootstrap-theme.css" />
        <link rel="stylesheet" type="text/css" href="http://wwwnew.ictp.it/css/ictp.css" />
        <link rel="stylesheet" type="text/css" href="http://wwwnew.ictp.it/css/ictp-md.css" />
        <link rel="stylesheet" type="text/css" href="http://wwwnew.ictp.it/css/ictp-indico-xs-sm.css" />        
        
        <link rel="stylesheet" type="text/css" href="/css/ICTP/css/font-awesome.min.css" />                                                                 
        <style>.nav>li { float: left; }</style>
        
        
        <script type="text/javascript" src="http://wwwnew.ictp.it/scripts/jquery.mobile.touch.min.custom.js"></script>
        


        <script type="text/javascript" src="/css/ICTP/js/ictp.js"></script>

        
        
        
        
        
    </head>
    % if page._conf:
    <body data-user-id="${ user.getId() if user else 'null' }" section="${page._conf.getOwner().getId()}">
    % else:
    <body data-user-id="${ user.getId() if user else 'null' }" section="${page._target.id}">
    % endif
    
        <%
import urllib2

# external website: I must use proxy
proxy = urllib2.ProxyHandler({'http': 'proxy.ictp.it:3128'})
opener = urllib2.build_opener(proxy)
urllib2.install_opener(opener)

try:
    response = urllib2.urlopen("http://wwwnew.ictp.it/headercalendar.aspx")
    headers = response.info()
    data = response.read()
except:
    data = '<img src="http://indico.ictp.it/css/ICTP/images/logo_ictp_v3_50th.png"  style="display:block;background-color: blue;"  />'
%>



        

  ${ data }    
    
        ${ page._getWarningMessage() }
    % if analyticsActive and analyticsCodeLocation == "body":
        ${analyticsCode}
    % endif
