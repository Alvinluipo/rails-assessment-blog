$( document ).ready(function() {
  
  $("#all_comments").click(function(e){

    clearDom();
    getPosts();
    e.preventDefault();
  });

  $("#show_comment").click(function() {
    getComment();
  });
});  

  function getPosts() {
  
    $.get("comments.json", function(response) {
      populatePosts(response);
    });
  };

  function clearDom(){
   
    $( "#display" ).empty();
  }

  function populatePosts(r){
    r.forEach(function( postData ) {
      var cur = new Comment(postData)
      var post = "<li>"

        post += (cur.postTitle).toString();
        post += "<br>"
        post += (cur.postBody).toString();
        post += "</li>" 
        post += (cur.toButton);
        post += "<br>"


      $("#display").append(post);

  
    });
  }

  // function getComment() {
  //   alert("testing");
  
  //   $.get("show.json", function(response) {
  //     populatePosts(response);
  //   });
  // };

  function Comment(d) {

    this.name = d.name;
    this.body = d.body;
    this.id = d.id;
    this.postTitle = d.post.title;
    this.postBody = d.post.body;
    this.toButton =  "<button id='show_comment" + this.id + "'> Show Comment </button>";  
  }

  Comment.prototype.last = function(){
    var lastComment = Comment.last;
  }


