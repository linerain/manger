<%@tag import="java.util.List"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@tag description="" pageEncoding="UTF-8"%>

<%@ attribute name="ctx" required="true" %>
<%@ attribute name="panelName" required="true" %>
<%@ attribute name="location" required="true" %>

 <TABLE cellSpacing=0 cellPadding=0 width="98%" align=center border=0>
  <TR height=20>
    <TD></TD></TR>
  <TR height=22>
    <TD style="PADDING-LEFT: 10px; FONT-WEIGHT: bold; COLOR: #ffffff" 
    align='${location}' background='${ctx}/img/title_bg2.jpg'>${panelName }</TD></TR>
  <TR bgColor=#ecf4fc height=12>
    <TD></TD></TR>
  <TR height=20>
    <TD></TD></TR></TABLE>