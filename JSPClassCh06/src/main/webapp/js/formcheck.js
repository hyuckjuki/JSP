/**
 * 
 */
 $(function() {
   
   // 삭제하기 버튼이 클릭되면
   $("#detailDelete").click(function() {
      
      // 1. 비밀번호 입력란에 비밀번호가 입력되었는지 확인
      var pass = $("#pass").val();
      
      if(pass.trim().length == 0) {
         alert("게시 글을 삭제하려면 비밀번호를 입력해야 합니다.");
         $("#pass").val("");
         
         return;
      }
      
      var no = $(this).prev().attr("data-no");
      $("#rNo").val(no);
      $("#rPass").val(pass);
      
      $("#checkForm").attr("action", "deleteProcess.jsp");
      $("#checkForm").attr("method", "post");
      
      $("#checkForm").submit();
                        
   });
   
   // 수정하기 버튼이 클릭되면
   $("#detailUpdate").click(function() {
      
      // 1. 비밀번호 입력란에 비밀번호가 입력되었는지 확인
      var pass = $("#pass").val();
      
      if(pass.trim().length == 0) {
         alert("게시 글을 수정하려면 비밀번호를 입력해야 합니다.");
         $("#pass").val("");
         
         return;
      }
      
      var no = $(this).attr("data-no");
      $("#rNo").val(no);
      $("#rPass").val(pass);
      
      $("#checkForm").attr("action", "updateForm.jsp");
      $("#checkForm").attr("method", "post");
      
      $("#checkForm").submit();
                        
   });
   
   // 게시글 작성폼 유효성 검사
   $("#writeForm").on("submit", function(e) {      
      
      //e.preventDefault();
      //e.cancelBubble();
      
      if($("#writer").val().length <= 0) {
         alert("글쓴이가 입력되지 않았습니다.");
         return false;
      }
      
      if($("#title").val().length <= 0) {
         alert("제목이 입력되지 않았습니다.");
         return false;
      }
      
       if($("#pass").val().length <= 0) {
         alert("비밀번호가 입력되지 않았습니다.");
         return false;
      }
      
       if($("#content").val().length <= 0) {
         alert("게시글이 입력되지 않았습니다.");
         return false;
      }
   });
   
   // 게시글 수정폼 유효성 검사
   $("#updateForm").on("submit", function(e) {      
      
      //e.preventDefault();
      //e.cancelBubble();
      
      if($("#pass").val().length <= 0) {
         alert("비밀번호가 입력되지 않았습니다.");
         return false;
      }
      
      if($("#title").val().length <= 0) {
         alert("제목이 입력되지 않았습니다.");
         return false;
      }
      
      if($("#content").val().length <= 0) {
         alert("게시글이 입력되지 않았습니다.");
         return false;
      }
      
   });
   
});