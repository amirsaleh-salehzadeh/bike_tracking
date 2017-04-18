<%@page import="AppContents.Common.RiderENT"%>
<%@page import="java.util.ArrayList"%>
<head>
<script type="text/javascript">
function addRider(x){
	$('#riderID').val(x);
	$('#reqCode').val("addRider");
	submitTheForm();
}
</script>
</head>
<%
	ArrayList<RiderENT> chks = (ArrayList<RiderENT>)request.getSession().getAttribute("riders");
	if(chks!=null){
		for(int i = 0; i < chks.size(); i++){
%>
<li id="<%=chks.get(i).getRiderTagId()%>" style="cursor: pointer;">
	<a href="#"><%=chks.get(i).getRiderUsername()%></a></td>
			<td><a href="#"
				onclick="addRider(<%=chks.get(i).getRiderTagId()%>);"><img
					alt="add to the race" src="css/jquery-mobile/images/add.png"></a></td>
		</tr>
	</table>
</li>
<%
	}}
%>
