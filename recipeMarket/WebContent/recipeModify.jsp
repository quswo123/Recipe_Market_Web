<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Recipe Market - 오늘 뭐 먹지?</title>
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css?family=Roboto:300,400,400i,500,700,900" rel="stylesheet">
    <link rel="icon" href="${contextPath}/img/titlecon.png">
    <link rel="stylesheet" href="${contextPath}/css/header.css">
    <link rel="stylesheet" href="${contextPath}/css/customScrollBar.css">
    <link rel="stylesheet" href="${contextPath}/css/divContent.css">
    <link rel="stylesheet" href="${contextPath}/css/contents.css">
    <link rel="stylesheet" href="${contextPath}/css/footer.css">
    <link rel="stylesheet" href="${contextPath}/css/recipeInfo.css">
    <link rel="stylesheet" href="${contextPath}/css/recipeModify.css">
    
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="${contextPath}/js/dropdownMenu.js"></script>
    <script src="${contextPath}/js/favoriteBtn.js"></script>
    
	<c:choose>
		<c:when test="${userType == 'A'}">
			<script src="${contextPath}/js/header_admin.js"></script>
	    </c:when>
	    <c:otherwise>
	    	<script src="${contextPath}/js/header_rnd.js"></script>
	    </c:otherwise>
    </c:choose>
    
    <script src="${contextPath}/js/footer.js"></script>
<%--     <script src="${contextPath}/js/recipeInfo.js"></script> --%>
    <script src="${contextPath}/js/recipeModify.js"></script>
    
    <script>
    	$(function(){
    		$('.ingAddBtn').click(function(){
    			var tag = ''
    			tag +='<tr>';
    			tag +='<td align="center">';
    			tag +='<input size="28" class="dataInput" type="text" id="ingredientsName" name="ingredientsName" placeholder="재료을 입력하세요.">';
    			tag +='</td>';
    			tag +='<td align="center">';
    			tag +='<input size="28" class="dataInput" type="text" id="ingredientsSize" name="ingredientsSize" placeholder="용량을 입력하세요.">';
    			tag +='</td>';
    			tag +='<td align="left">';
    			tag +='<button class="ingDeleteBtn" type="button">';
    			tag +='재료삭제';
    			tag +='</button>';
    			tag +='</td>';
    			tag +='</tr>';
    			$('.ingredientsWrapper').append(tag);
    		});
    		
    		$('.ingredientsWrapper').on('click','.ingDeleteBtn', function() {
    			if (confirm("선택하신 재료를 삭제하시겠습니까?")) {
        			var clickedRow = $(this).parent().parent();
        			clickedRow.remove();
    			}
    		});
    		
    		$('.processAddBtn').click(function(){
    			var tag = ''
    			tag +='<tr>';
    			tag +='<td colspan="2">';
    			tag +='<input size="60" class="dataInput" type="text" id="recipeProcess" name="recipeProcess" placeholder="과정을 입력하세요.">';
    			tag +='</td>';
    			tag +='<td align="left">';
    			tag +='<button class="processDeleteBtn" type="button">';
    			tag +='과정삭제';
    			tag +='</button>';
    			tag +='</td>';
    			tag +='</tr>';
    			$('.recipeProcessWrapper').append(tag);
    		});
    		
    		$('.recipeProcessWrapper').on('click','.prcoessDeleteBtn', function(){
				if(confirm("선택하신 과정을 삭제하시겠습니까?")){
	    			var clickedRow = $(this).parent().parent();
	    			clickedRow.remove();
				}
    		});
    		
    		$('.recipeModifyBtn').click(function(){
    			var recipeCode = $("#recipeCode").val();
    			var recipeName = $("#recipeName").val();
    			var ingNameObj = $("input[name=ingredientsName]");
    			var ingSizeObj = $("input[name=ingredientsSize]");
    			var recipeSumm = $("input[name=recipeSumm]").val();
    			var recipePrice = $("input[name=recipePrice]").val();
    			var recipeProcessObj = $("input[name=recipeProcess]");
    			var recipeImage = $("input[name=imageUpload]")[0].files[0];

    			if (recipeName == '') {
    				alert("레시피명을 입력해주세요!");
    				$("#recipeName").focus();
    				return;
    			}

    			// formData Setting
    			var formData = new FormData();
    			formData.append("recipeCode", recipeCode);
    			formData.append("recipeName", recipeName);
    			var ingName = [];
    			for (var i=0; i<ingNameObj.length; i++) {
    				ingName.push(ingNameObj[i].value);
    			}
    			formData.append("ingName", ingName);
    			var ingSize = [];
    			for (var i=0; i<ingSizeObj.length; i++) {
    				ingSize.push(ingSizeObj[i].value);
    			}
    			formData.append("ingSize", ingSize);
    			formData.append("recipeSumm", recipeSumm);
    			formData.append("recipePrice", recipePrice);
    			var recipeProcess = [];
    			for (var i=0; i<recipeProcessObj.length; i++) {
    				recipeProcess.push(recipeProcessObj[i].value);
    			}
    			formData.append("recipeProcess", recipeProcess);
    			formData.append("recipeImage", recipeImage);

    			// formData 데이터 확인하기
    			/* for (var key of formData.keys()) {
					console.log(key, formData.get(key));
				} */

// 				alert("hello");
				
    			// 수정 ajax 호출
    			$.ajax({
    				url: '${contextPath}/recipeEdit'
    				,method:'post'
    				,enctype:'multipart/form-data'
    				,cache: false
       				,processData: false
       				,contentType: false
    				,data:formData
    				,success:function(data) {
    					if (data != null && data.status == "success") {
    						alert("수정되었습니다.");
    						// 리스트로 이동
    						location.href = "/recipeMarket/index_rnd.jsp";
    					} else {
    						alert(data.msg);
    					}
    				}
    			});
    			return false;
    		});
    	});
    </script>
    
</head>

<body>
    <header>
        <!-- 왼쪽 영역 -->
        <div class="headerLeftSection">
            <!-- 뒤로 가기 버튼 -->
            <a class="glyphicon glyphicon-chevron-left"></a>
            <!-- 로고(홈 버튼) -->
            <h1 class="home">RECIPE MARKET</h1>
        </div>
        <!-- 오른쪽 영역 -->
        <div class="headerRightSection">
            <jsp:include page="dropdownMenu_rnd.jsp"></jsp:include>
        </div>
    </header>
    <div class="divContent">
        <section class="leftSection">
            <!-- 화면 제목(또는 레시피 이름) -->
            <h1>레시피 수정</h1>
            <hr><br>
        </section>
        <!-- 오른쪽 영역 (화면에 따라 동적 생성 필요) -->
        <section class="rightSection">
                                        
        <div class="contentsWrapper">

            <div class="infoWrapper">

                <form class="formWrapper" action="#" method="post">
                	<input type=hidden id="recipeCode" name="recipeCode" value="${requestScope.recipeInfo.recipeCode}">
					<table>
						<thead>
		                    <tr>
		                        <td colspan="2"><input size="60" class="dataInput" type="text" id="recipeName" name="recipeName" value="${requestScope.recipeInfo.recipeName}" placeholder="레시피명을 입력하세요."></td><!-- 레시피명이 이미 존재합니다 -->
		                    </tr>
						</thead>
						<tbody class="ingredientsWrapper">
							<c:if test="${!empty requestScope.recipeInfo.ingredients}">
								<c:forEach var="ingInfo" items="${requestScope.recipeInfo.ingredients}" varStatus="status">
								<tr>
			                        <td align="center"><input size="28" class="dataInput" type="text" id="ingredientsName" name="ingredientsName" value="${ingInfo.ingredient.ingName}" placeholder="재료을 입력하세요."></td>
			                        <td align="center"><input size="28" class="dataInput" type="text" id="ingredientsSize" name="ingredientsSize" placeholder="용량을 입력하세요."></td>
			                        <td align="left">
			                        	<c:if test="${status.first}">
			                       		<button class="ingAddBtn" type="button">
			                       			재료추가
				                        </button>
				                        </c:if>
				                        <c:if test="${!status.first}">
			                       		<button class="ingDeleteBtn" type="button">
			                       			재료삭제
				                        </button>
				                        </c:if>
				                    </td>
			                    </tr>	
								</c:forEach>
							</c:if>
						</tbody>
						<tbody>
							<tr>
		                        <td colspan="2"><input size="60" class="dataInput" type="text" id="recipeSumm" name="recipeSumm" value="${requestScope.recipeInfo.recipeSumm}" placeholder="한줄요약을 입력하세요."></td><!-- 숫자만 입력하세요(유효성검사) -->
		                    </tr>
		                    <tr>
		                        <td colspan="2"><input size="60" class="dataInput" type="text" id="recipePrice" name="recipePrice" value="${requestScope.recipeInfo.recipePrice}" placeholder="가격을 입력하세요."></td><!-- 숫자만 입력하세요(유효성검사) -->
		                    </tr>
						</tbody>
						<tbody class="recipeProcessWrapper">
		                    <tr>
		                        <td colspan="2"><input size="60" class="dataInput" type="text" id="recipeProcess" name="recipeProcess" placeholder="과정을 입력하세요."></td>
		                        <td align="left">
		                       		<button class="processAddBtn" type="button">
		                           		과정추가
			                        </button>
			                    </td>
		                    </tr>
						</tbody>
						<tbody>
		                    <tr>
		                        <td colspan="2"><input size="60" class="dataInput" type="file" id="imageUpload" name="imageUpload" placeholder="이미지를 추가하세요."></td>
		                    </tr>
	                   </tbody>
                   </table>
                   <div class="buttonSection">
                       <button class="recipeModifyBtn" type="submit">
                           레시피수정
                       </button>
                   </div>
                </form>
            </div>
        </div>                             
        </section>

    </div>
    <footer>
        <p>
            © 2020 RECIPE MARKET All rights reserved.
        </p>
        <a class="topBtn">&uarr;TOP</a>
    </footer>
</body>

</html>