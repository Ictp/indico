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

        <link rel="stylesheet" type="text/css" href="/css/ICTP/css/bootstrap.min.css" />
        <link rel="stylesheet" type="text/css" href="/css/ICTP/css/bootstrap-theme.css" />
        <link rel="stylesheet" type="text/css" href="/css/ICTP/css/ictp.css" />
        <link rel="stylesheet" type="text/css" href="/css/ICTP/css/ictp-md.css" />
        <link rel="stylesheet" type="text/css" href="/css/ICTP/css/ictp-indico-xs-sm.css" />        
        
        <link rel="stylesheet" type="text/css" href="/css/ICTP/css/font-awesome.min.css" />                                                                 
        <style>.nav>li { float: left; }</style>
        
        
        <script type="text/javascript" src="/css/ICTP/js/jquery.mobile.touch.min.custom.js"></script>
        


        <script type="text/javascript" src="/css/ICTP/js/ictp.js"></script>

        
        
        
        
        
    </head>
    <%
        section = ''
        try:
            if hasattr(page,'_conf') and page._conf:
                section=page._conf.getOwner().getId()
            if hasattr(page,'_target'):
                section=page._target.id
        except:
            pass
    %>
    <body data-user-id="${ user.getId() if user else 'null' }" section="${section}">
    

<%include file="PromoscienceHeader.ICTP.tpl" />


        

    
        ${ page._getWarningMessage() }
    % if analyticsActive and analyticsCodeLocation == "body":
        ${analyticsCode}
    % endif
