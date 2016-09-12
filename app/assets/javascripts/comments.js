$( document ).ready(function() {
  
  $("#all_comments").click(function(e){

    clearDom();
    getComments();
    e.preventDefault();
  });
});  

  function getComments() {
  
    $.get("comments.json", function(response) {
      populateComments(response);
    });
  };

  function clearDom(){
   
    $( "#display" ).empty();
  }

  function populateComments(r){
    $( r ).each(function( index ) {
      var post = "<li>"

        post += (this.post.title).toString();
        post += "<br>"
        post += (this.post.body).toString();
        post += "</li>"
      $("#display").append(post);

      console.log(this.post.title);
    });
  }

