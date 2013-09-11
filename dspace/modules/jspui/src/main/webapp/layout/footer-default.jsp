<%--

    The contents of this file are subject to the license and copyright
    detailed in the LICENSE and NOTICE files at the root of the source
    tree and available online at

    http://www.dspace.org/license/

--%>
<%--
  - Footer for home page
  --%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%@ page contentType="text/html;charset=UTF-8" %>

<%@ page import="java.net.URLEncoder" %>
<%@ page import="org.dspace.app.webui.util.UIUtil" %>

<%
    String sidebar = (String) request.getAttribute("dspace.layout.sidebar");
    int overallColSpan = 3;
    if (sidebar == null)
    {
        overallColSpan = 2;
    }
%>
                    <%-- End of page content --%>
                    <p>&nbsp;</p>
                </td>

            <%-- Right-hand side bar if appropriate --%>
<%
    if (sidebar != null)
    {
%>
                <td class="sidebar">
                    <%= sidebar %>
                </td>
<%
    }
%>
            </tr>

            <%-- Page footer --%>
             <tr class="pageFooterBar">
                <td colspan="<%= overallColSpan %>" class="pageFootnote">
                    <table class="pageFooterBar" width="100%">
                        <tr>
                            <td>
                                <a href="http://validator.w3.org/check?uri=referer"><img
                                    src="<%= request.getContextPath() %>/image/valid-xhtml10.png"
                                    alt="Valid XHTML 1.0!" height="31" width="88" /></a>
                            </td>
                            <td class="pageFootnote">
                                <fmt:message key="jsp.layout.footer-default.text"/>&nbsp;-
                                <a target="_blank" href="<%= request.getContextPath() %>/feedback"><fmt:message key="jsp.layout.footer-default.feedback"/></a>
                                <a href="<%= request.getContextPath() %>/htmlmap"></a>
                            </td>
                            <td nowrap="nowrap" valign="middle"> <%-- nowrap, valign for broken NS 4.x --%>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        <!-- updated version of jquery -->
        <!-- uncomment for production enviroment -->
        <!--<script src="//ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>-->
        <script>window.jQuery || document.write("&lt;script src='<%= request.getContextPath() %>/static/js/jquery/jquery-1.10.2.min.js' &gt; &lt;\/script &gt; &lt;script src='<%= request.getContextPath() %>/static/js/jquery/jquery-ui-1.10.3.custom.min' &gt; &lt;\/script&gt;");</script>
        
        <!-- DSpace default js stuff -->
        <!-- TODO: Delete when necesary-->
        <script type="text/javascript" src="<%= request.getContextPath() %>/utils.js"></script>
        <script type="text/javascript" src="<%= request.getContextPath() %>/static/js/scriptaculous/prototype.js"> </script>
        <script type="text/javascript" src="<%= request.getContextPath() %>/static/js/scriptaculous/effects.js"> </script>
        <script type="text/javascript" src="<%= request.getContextPath() %>/static/js/scriptaculous/builder.js"> </script>
        <script type="text/javascript" src="<%= request.getContextPath() %>/static/js/scriptaculous/controls.js"> </script>
        <script type="text/javascript" src="<%= request.getContextPath() %>/static/js/choice-support.js"> </script>
    </body>
</html>