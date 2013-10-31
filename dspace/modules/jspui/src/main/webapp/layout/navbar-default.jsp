<%--

    The contents of this file are subject to the license and copyright
    detailed in the LICENSE and NOTICE files at the root of the source
    tree and available online at

    http://www.dspace.org/license/

--%>
<%--
  - Default navigation bar
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%@ page contentType="text/html;charset=UTF-8" %>

<%@ taglib uri="/WEB-INF/dspace-tags.tld" prefix="dspace" %>

<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="javax.servlet.jsp.jstl.fmt.LocaleSupport" %>
<%@ page import="org.dspace.app.webui.util.UIUtil" %>
<%@ page import="org.dspace.content.Collection" %>
<%@ page import="org.dspace.content.Community" %>
<%@ page import="org.dspace.eperson.EPerson" %>
<%@ page import="org.dspace.core.ConfigurationManager" %>
<%@ page import="org.dspace.browse.BrowseIndex" %>
<%@ page import="org.dspace.browse.BrowseInfo" %>
<%@ page import="java.util.Map" %>
<%
    // Is anyone logged in?
    EPerson user = (EPerson) request.getAttribute("dspace.current.user");

    // Is the logged in user an admin
    Boolean admin = (Boolean)request.getAttribute("is.admin");
    boolean isAdmin = (admin == null ? false : admin.booleanValue());

    // Get the current page, minus query string
    String currentPage = UIUtil.getOriginalURL(request);
    int c = currentPage.indexOf( '?' );
    if( c > -1 )
    {
        currentPage = currentPage.substring( 0, c );
    }

    // E-mail may have to be truncated
    String navbarEmail = null;

    if (user != null)
    {
        navbarEmail = user.getEmail();
        if (navbarEmail.length() > 18)
        {
            navbarEmail = navbarEmail.substring(0, 17) + "...";
        }
    }
    
    // get the browse indices
    
        BrowseIndex[] bis = BrowseIndex.getBrowseIndices();
    BrowseInfo binfo = (BrowseInfo) request.getAttribute("browse.info");
    String browseCurrent = "";
    if (binfo != null)
    {
        BrowseIndex bix = binfo.getBrowseIndex();
        // Only highlight the current browse, only if it is a metadata index,
        // or the selected sort option is the default for the index
        if (bix.isMetadataIndex() || bix.getSortOption() == binfo.getSortOption())
        {
            if (bix.getName() != null)
                        browseCurrent = bix.getName();
        }
    }
%>

<%-- Search Box --%>
<form method="get" action="<%= request.getContextPath() %>/simple-search">

    <%
        if (user != null)
        {
    %>
    <p class="loggedIn"><fmt:message key="jsp.layout.navbar-default.loggedin">
            <fmt:param><%= navbarEmail %></fmt:param>
        </fmt:message>
        (<a href="<%= request.getContextPath() %>/logout"><fmt:message key="jsp.layout.navbar-default.logout"/></a>)</p>
        <%
            }
        %>
    <div class="searchBox">
        <div>
            <div class="searchBoxLabel"><label for="tequery"><fmt:message key="jsp.layout.navbar-default.search"/></label></div>
        </div>
        <div>
            <div class="searchBoxLabelSmall">
                <%-- <input type="text" name="query" id="tequery" size="10"/><input type=image border="0" src="<%= request.getContextPath() %>/image/search-go.gif" name="submit" alt="Go" value="Go"/> --%>
                <input type="text" name="query" id="tequery" size="8"/><input type="submit" name="submit" value="<fmt:message key="jsp.layout.navbar-default.go"/>" />
                <br/><a href="<%= request.getContextPath() %>/advanced-search"><fmt:message key="jsp.layout.navbar-default.advanced"/></a>
                <%
                                        if (ConfigurationManager.getBooleanProperty("webui.controlledvocabulary.enable"))
                                        {
                %>        
                <br/><a href="<%= request.getContextPath() %>/subject-search"><fmt:message key="jsp.layout.navbar-default.subjectsearch"/></a>
                <%
                            }
                %>
            </div>
        </div>
    </div>
</form>

<%-- HACK: width, border, cellspacing, cellpadding: for non-CSS compliant Netscape, Mozilla browsers --%>
<div>
    <div class="navigationBarItem">
        <div>
            <img alt="" src="<%= request.getContextPath() %>/image/<%= (currentPage.endsWith("/index.jsp") ? "arrow-highlight" : "arrow") %>.gif" width="16" height="16"/>
        </div>

        <div nowrap="nowrap" class="navigationBarItem">
            <a href="<%= request.getContextPath() %>/"><fmt:message key="jsp.layout.navbar-default.home"/></a>
        </div>
    </div>

    <div>
        <div>&nbsp;</div>
    </div>

    <div>
        <div nowrap="nowrap" colspan="2" class="navigationBarSublabel"><fmt:message key="jsp.layout.navbar-default.browse"/></div>
    </div>

    <div class="navigationBarItem">
        <div>
            <img alt="" src="<%= request.getContextPath() %>/image/<%= ( currentPage.endsWith( "/community-list" ) ? "arrow-highlight" : "arrow" ) %>.gif" width="16" height="16"/>
        </div>
        <div nowrap="nowrap" class="navigationBarItem">
            <a href="<%= request.getContextPath() %>/community-list"><fmt:message key="jsp.layout.navbar-default.communities-collections"/></a>
        </div>
    </div>


    <%-- Insert the dynamic browse indices here --%>

    <%
            for (int i = 0; i < bis.length; i++)
            {
                    BrowseIndex bix = bis[i];
                    String key = "browse.menu." + bix.getName();
    %>
    <div class="navigationBarItem">
        <div>
            <img alt="" src="<%= request.getContextPath() %>/image/<%= ( browseCurrent.equals(bix.getName()) ? "arrow-highlight" : "arrow" ) %>.gif" width="16" height="16"/>
        </div>
        <div nowrap="nowrap" class="navigationBarItem">
            <a href="<%= request.getContextPath() %>/browse?type=<%= bix.getName() %>"><fmt:message key="<%= key %>"/></a>
        </div>
    </div>
    <%	
    }
    %>

    <%-- End of dynamic browse indices --%>

    <div>
        <div>&nbsp;</div>
    </div>

    <div>
        <div nowrap="nowrap" colspan="2" class="navigationBarSublabel"><fmt:message key="jsp.layout.navbar-default.sign"/></div>
    </div>

    <div class="navigationBarItem">
        <div>
            <img alt="" src="<%= request.getContextPath() %>/image/<%= ( currentPage.endsWith( "/subscribe" ) ? "arrow-highlight" : "arrow" ) %>.gif" width="16" height="16"/>
        </div>
        <div nowrap="nowrap" class="navigationBarItem">
            <a href="<%= request.getContextPath() %>/subscribe"><fmt:message key="jsp.layout.navbar-default.receive"/></a>
        </div>
    </div>

    <div class="navigationBarItem">
        <div>
            <img alt="" src="<%= request.getContextPath() %>/image/<%= ( currentPage.endsWith( "/mydspace" ) ? "arrow-highlight" : "arrow" ) %>.gif" width="16" height="16"/>
        </div>
        <div nowrap="nowrap" class="navigationBarItem">
            <a href="<%= request.getContextPath() %>/mydspace"><fmt:message key="jsp.layout.navbar-default.users"/></a><br/>
            <fmt:message key="jsp.layout.navbar-default.users-authorized" />
        </div>
    </div>

    <div class="navigationBarItem">
        <div>
            <img alt="" src="<%= request.getContextPath() %>/image/<%= ( currentPage.endsWith( "/profile" ) ? "arrow-highlight" : "arrow" ) %>.gif" width="16" height="16"/>
        </div>
        <div nowrap="nowrap" class="navigationBarItem">
            <a href="<%= request.getContextPath() %>/profile"><fmt:message key="jsp.layout.navbar-default.edit"/></a>
        </div>
    </div>

    <%
      if (isAdmin)
      {
    %>  
    <div class="navigationBarItem">
        <div>
            <img alt="" src="<%= request.getContextPath() %>/image/<%= ( currentPage.endsWith( "/dspace-admin" ) ? "arrow-highlight" : "arrow" ) %>.gif" width="16" height="16"/>
        </div>
        <div nowrap="nowrap" class="navigationBarItem">
            <a href="<%= request.getContextPath() %>/dspace-admin"><fmt:message key="jsp.administer"/></a>
        </div>
    </div>
    <%
      }
    %>

    <div>
        <div colspan="2">&nbsp;</div>
    </div>

    <div class="navigationBarItem">
        <div>
            <img alt="" src="<%= request.getContextPath() %>/image/<%= ( currentPage.endsWith( "/help" ) ? "arrow-highlight" : "arrow" ) %>.gif" width="16" height="16"/>
        </div>
        <div nowrap="nowrap" class="navigationBarItem">
            <dspace:popup page="<%= LocaleSupport.getLocalizedMessage(pageContext, \"help.index\")%>"><fmt:message key="jsp.layout.navbar-default.help"/></dspace:popup>
            </div>
        </div>

        <div class="navigationBarItem">
            <div>
                <img alt="" src="<%= request.getContextPath() %>/image/<%= ( currentPage.endsWith( "/about" ) ? "arrow-highlight" : "arrow" ) %>.gif" width="16" height="16"/>
        </div>
        <div nowrap="nowrap" class="navigationBarItem">
            <a href="http://www.dspace.org/"><fmt:message key="jsp.layout.navbar-default.about"/></a>
        </div>
    </div>
</div>
