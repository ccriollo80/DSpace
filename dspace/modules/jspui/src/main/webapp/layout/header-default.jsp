<%--

    The contents of this file are subject to the license and copyright
    detailed in the LICENSE and NOTICE files at the root of the source
    tree and available online at

    http://www.dspace.org/license/

--%>
<%--
  - HTML header for main home page
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.dspace.org/dspace-tags.tld" prefix="dspace" %>

<%@ page contentType="text/html;charset=UTF-8" %>

<%@ page import="java.util.List"%>
<%@ page import="java.util.Enumeration"%>
<%@ page import="org.dspace.app.webui.util.JSPManager" %>
<%@ page import="org.dspace.core.ConfigurationManager" %>
<%@ page import="org.dspace.app.util.Util" %>
<%@ page import="javax.servlet.jsp.jstl.core.*" %>
<%@ page import="javax.servlet.jsp.jstl.fmt.*" %>

<%
    String title = (String) request.getAttribute("dspace.layout.title");
    String navbar = (String) request.getAttribute("dspace.layout.navbar");
    boolean locbar = ((Boolean) request.getAttribute("dspace.layout.locbar")).booleanValue();

    String siteName = ConfigurationManager.getProperty("dspace.name");
    String feedRef = (String)request.getAttribute("dspace.layout.feedref");
    boolean osLink = ConfigurationManager.getBooleanProperty("websvc.opensearch.autolink");
    String osCtx = ConfigurationManager.getProperty("websvc.opensearch.svccontext");
    String osName = ConfigurationManager.getProperty("websvc.opensearch.shortname");
    List parts = (List)request.getAttribute("dspace.layout.linkparts");
    String extraHeadData = (String)request.getAttribute("dspace.layout.head");
    String extraHeadDataLast = (String)request.getAttribute("dspace.layout.head.last");
    String dsVersion = Util.getSourceVersion();
    String generator = dsVersion == null ? "DSpace" : "DSpace "+dsVersion;
    String analyticsKey = ConfigurationManager.getProperty("jspui.google.analytics.key");
%>

<!-- Changing to the html5 doctype -->
<!DOCTYPE html>
<html>
    <head>
        <title><%= siteName %>: <%= title %></title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="Generator" content="<%= generator %>" />

        <!-- including meta tag for mobile compatibility -->
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <!-- including bootstrap css bootstrap files-->
        <!-- TODO: Now we are using the compiled version it must be changed to the source one and then compiled with less or recess -->
        <link rel="stylesheet" href="<%= request.getContextPath() %>/static/css/bootstrap/bootstrap.min.css"  media="screen">

        <!-- Default DSpace css stuff -->
        <!-- TODO: Delete when necesary-->
        <link rel="stylesheet" href="<%= request.getContextPath() %>/styles.css" type="text/css" />
        <link rel="stylesheet" href="<%= request.getContextPath() %>/print.css" media="print" type="text/css" />
        <link rel="shortcut icon" href="<%= request.getContextPath() %>/favicon.ico" type="image/x-icon"/>
        <link rel="stylesheet" href="<%= request.getContextPath() %>/css/discovery.css" type="text/css" />
        <!-- updated version and theme of jquery-ui-->
        <link rel="stylesheet" href="<%= request.getContextPath() %>/static/css/jquery-ui-1.10.3.custom/ui-lightness/jquery-ui-1.10.3.custom.css" type="text/css" />

        <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
        <!--[if lt IE 9]>
        <script src="<%= request.getContextPath() %>/static/js/html5shiv.js"></script>
        <script src="<%= request.getContextPath() %>/static/js/respond.min.js"></script>
        <![endif]-->
        <%
            if (!"NONE".equals(feedRef))
            {
                for (int i = 0; i < parts.size(); i+= 3)
                {
        %>
        <link rel="alternate" type="application/<%= (String)parts.get(i) %>" title="<%= (String)parts.get(i+1) %>" href="<%= request.getContextPath() %>/feed/<%= (String)parts.get(i+2) %>/<%= feedRef %>"/>
        <%
                }
            }
    
            if (osLink)
            {
        %>
        <link rel="search" type="application/opensearchdescription+xml" href="<%= request.getContextPath() %>/<%= osCtx %>description.xml" title="<%= osName %>"/>
        <%
            }

            if (extraHeadData != null)
                { %>
        <%= extraHeadData %>
        <%
                }
        %>
        <!-- All scripts were sent to the end of body -->    


        <%--Gooogle Analytics recording.--%>
        <%
        if (analyticsKey != null && analyticsKey.length() > 0)
        {
        %>
        <script type="text/javascript">
            var _gaq = _gaq || [];
            _gaq.push(['_setAccount', '<%= analyticsKey %>']);
            _gaq.push(['_trackPageview']);

            (function() {
                var ga = document.createElement('script');
                ga.type = 'text/javascript';
                ga.async = true;
                ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
                var s = document.getElementsByTagName('script')[0];
                s.parentNode.insertBefore(ga, s);
            })();
        </script>
        <%
        }
        if (extraHeadDataLast != null)
        { %>
        <%= extraHeadDataLast %>
        <%
            }
        %>

    </head>

    <%-- HACK: leftmargin, topmargin: for non-CSS compliant Microsoft IE browser --%>
    <%-- HACK: marginwidth, marginheight: for non-CSS compliant Netscape browser --%>
    <body>

        <%-- DSpace top-of-page banner --%>
        <%-- HACK: width, border, cellspacing, cellpadding: for non-CSS compliant Netscape, Mozilla browsers --%>

        <header>
            <div class="btn-group pull-right">
                <button type="button" class="btn btn-default"><span class="glyphicon glyphicon-ok"></span></button>
                <button type="button" class="btn btn-default"><span class="glyphicon glyphicon-search"></span></button>
                <div class="btn-group">
                    <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
                        <span class="glyphicon glyphicon-align-justify"></span>
                    </button>
                    <ul class="dropdown-menu">
                        <li><a href="#">Dropdown link</a></li>
                        <li><a href="#">Dropdown link</a></li>
                    </ul>
                </div>
            </div>
        </header>

        <div class="pageBanner">

            <%-- DSpace logo --%>
            <div>
                <div>
                    <a href="<%= request.getContextPath() %>/"><img src="<%= request.getContextPath() %>/image/dspace-blue.gif" alt="<fmt:message key="jsp.layout.header-default.alt"/>" width="198" height="79" border="0"/></a>
                </div>
                <div class="tagLine"> <%-- Make as wide as possible. cellpadding repeated for broken NS 4.x --%>
                    <a class="tagLineText" target="_blank" href="http://www.dspace.org/"><fmt:message key="jsp.layout.header-default.about"/></a>
                </div>
                <div>
                </div>
            </div>
            <div class="stripe"> <%-- Blue stripe --%>
                <div>&nbsp;</div>
            </div>
        </div>

        <%-- Localization --%>
        <%--  <c:if test="${param.locale != null}">--%>
        <%--   <fmt:setLocale value="${param.locale}" scope="session" /> --%>
        <%-- </c:if> --%>
        <%--        <fmt:setBundle basename="Messages" scope="session"/> --%>

        <%-- Page contents --%>

        <%-- HACK: width, border, cellspacing, cellpadding: for non-CSS compliant Netscape, Mozilla browsers --%>
        <div class="centralPane">

            <%-- HACK: valign: for non-CSS compliant Netscape browser --%>
            <div valign="top">

                <%-- Navigation bar --%>
                <%
                    if (!navbar.equals("off"))
                    {
                %>
                <div class="navigationBar">
                    <dspace:include page="<%= navbar %>" />
                </div>
                <%
                    }
                %>
                <%-- Page Content --%>

                <%-- HACK: width specified here for non-CSS compliant Netscape 4.x --%>
                <%-- HACK: Width shouldn't really be 100%, but omitting this means --%>
                <%--       navigation bar gets far too wide on certain pages --%>
                <div class="pageContents" width="100%">

                    <%-- Location bar --%>
                    <%
                        if (locbar)
                        {
                    %>
                    <dspace:include page="/layout/location-bar.jsp" />
                    <%
                        }
                    %>
