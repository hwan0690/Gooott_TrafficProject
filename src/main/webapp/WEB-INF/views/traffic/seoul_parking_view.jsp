<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" />
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=9bdfa0d98e7c6b1949b387b6e48e0de3&libraries=services"></script>
</head>
<body>
	
	<style>
	
		#content{
			height: auto;
			width: 1200px;
			margin-left: auto;
			margin-right: auto;
		}
		h2 {
			text-align: center;
		}
		table {
			margin-top: 20px;
			margin-left: auto;
			margin-right: auto;
			width: 800px;
			height: auto;
			
		}
		tr, td {
			padding-top: 15px;
			/* padding-bottom: 5px; */
			font-size: 16px;
		}
		tr {
			width: auto;
			border: 1px solid black;
		}
		td {
			padding: 13px 0;
			padding-left: 10px;
			/* padding-left: 10px; */
			border-bottom: 1px solid #cbcbcb;
		}
		table tr td:first-child {
	        width: 150px;
	        font-weight: bold;
    	}
		table tr td:nth-child(2) {
	        color: #525252;
    	}
    	#listbtn-container {
	        text-align: right;
	        margin-top: 10px;
	        width: 800px; /* �θ� �����̳��� �ʺ� ���� */
	        margin-left: auto;
	        margin-right: auto;
	    }
    	#listbtn {
    		background-color: #f5f5f5;
		    color: #525252;
		    border: 1px solid grey;
		    padding: 5px 10px;
		    border-radius: 5px;
		    /* float: right; */
    	}
    	#hr-container {
    		text-align: center;
    	}
    	hr {
    		height: 1px;
    		text-align: center;
    		width: 800px;
    		color: #cbcbcb;
    		margin: 20px auto;
    	}
    	#pre_next_table td:first-child{
    		background-color: #f5f5f5;
    	}
	</style>
	
	<script>
		function list() {
			window.location.replace('parking');
		}
	</script>
		
	
	<h2>����� ���������� ������</h2>
		<table>
			<tr>
				<td>�̸�</td>
				<td>${seoul_parking_view.p_name }</td>
			</tr>
			<tr>
				<td>�ּ�</td>
				<td>${seoul_parking_view.p_address }</td>
			</tr>
			<tr>
				<td>����</td>
				<td>${seoul_parking_view.p_kind_name }</td>
			</tr>
			<tr>
				<td>�</td>
				<td>${seoul_parking_view.p_management_name }</td>
			</tr>
			<tr>
				<td>��/����</td>
				<td>${seoul_parking_view.p_paid_and_free_name }</td>
			</tr>
			<tr>
				<td>�߰� �</td>
				<td>${seoul_parking_view.p_free_night }</td>
			</tr>
			<tr>
				<td>�</td>
				<td>${seoul_parking_view.p_management_name }</td>
			</tr>
			<tr>
				<td>���� ���� ���</td>
				<td>${seoul_parking_view.p_total_space }��</td>
			</tr>
			<tr>
				<td>��ȭ��ȣ</td>
				<td>
					<c:choose>
						<c:when test="${seoul_parking_view.p_tel == null }">
							��ȭ��ȣ ����
						</c:when>
						<c:otherwise>
							${seoul_parking_view.p_tel }
						</c:otherwise>
					</c:choose>
					
				</td>
			</tr>
			<tr>
				<td>��ð�</td>
				<td>
					<c:choose>
						<c:when test="${seoul_parking_view.p_week_open_time eq 0}">
						</c:when>
						<c:otherwise>
							���� : ${seoul_parking_view.p_week_open_time }~
							${seoul_parking_view.p_week_end_time } <br />
							�ָ� �� ������ : ${seoul_parking_view.p_weekend_open_time }~
							${seoul_parking_view.p_weekend_end_time }
						</c:otherwise>
					</c:choose>
				</td>
			</tr>
			<tr>
				<td>�⺻ �ð� / �⺻ ���</td>
				<td>${seoul_parking_view.p_default_time_min}�� / ${seoul_parking_view.p_default_price }��</td>
			</tr>
			<tr>
				<td>�߰� �ð� / �߰� ���</td>
				<td>${seoul_parking_view.p_add_price_min }�� / ${seoul_parking_view.p_add_price }��</td>
			</tr>
			<tr>
			    <td>�൵</td>
			    <td>
			        <div id="mapContainer" style="width:500px;height:350px;"></div>
			        <div id="noMapMessage" style="display:none;">�൵����</div>
			        <script>
			            var mapContainer = document.getElementById('mapContainer'); // ������ ǥ���� div 
			            var noMapMessage = document.getElementById('noMapMessage'); // �൵���� �޽����� ǥ���� div
			            var latitude = ${seoul_parking_view.p_latitude};
			            var hardness = ${seoul_parking_view.p_hardness};
			            
			            if (latitude == null || hardness == null) {
			                // latitude �Ǵ� hardness�� null�̸� �൵���� ǥ��
			                noMapMessage.style.display = 'block';
			            } else {
			                var mapOption = { 
			                    center: new kakao.maps.LatLng(latitude, hardness), // ������ �߽���ǥ
			                    level: 3 // ������ Ȯ�� ����
			                };
			                
			                var map = new kakao.maps.Map(mapContainer, mapOption); // ������ �����մϴ�
			                
			                // ��Ŀ�� ǥ�õ� ��ġ�Դϴ� 
			                var markerPosition  = new kakao.maps.LatLng(latitude, hardness); 
			                
			                // ��Ŀ�� �����մϴ�
			                var marker = new kakao.maps.Marker({
			                    position: markerPosition
			                });
			                
			                // ��Ŀ�� ���� ���� ǥ�õǵ��� �����մϴ�
			                marker.setMap(map);
			                
			                // �Ʒ� �ڵ�� ���� ���� ��Ŀ�� �����ϴ� �ڵ��Դϴ�
			                // marker.setMap(null);    
			            }
			        </script>
			    </td>
			</tr>



		</table>
		<div id="hr-container">
			<hr />
		</div>
		
		<div>
			<table id="pre_next_table">
				<tr>
					<td>������</td>
					<td>${seoul_parking_view.p_name }</td>
				</tr>
				<tr>
					<td>������</td>
					<td>������</td>
				</tr>
			</table>
		</div>		
		
		<div id="hr-container">
			<hr />
		</div>
		
		
		<div id="listbtn-container">
			<button id="listbtn" onclick="list();">���</button>
		</div>
</body>
</html>
 