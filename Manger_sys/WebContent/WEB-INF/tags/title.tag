<%@tag import="java.util.List"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@tag description="" pageEncoding="UTF-8"%>

<%@ attribute name="ctx" required="true" %>
<%@ attribute name="titleName" required="true" %>

 <TABLE cellSpacing=0 cellPadding=0 width="100%" align=center border=0>
 <TR height=28>
   <TD background=${ctx}/img/title_bg1.jpg>&nbsp;&nbsp;当前位置: ${titleName}</TD></TR>
 <TR>
   <TD bgColor=#b1ceef height=1></TD></TR>
 <TR height=20>
   <TD background=${ctx}/img/shadow_bg.jpg></TD></TR>
 </TABLE>


