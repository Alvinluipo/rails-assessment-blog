$( document ).ready(function() {
  
  $("#all_comments").click(function(e){

    clearDom();
    getPosts();
    e.preventDefault();
  });

  // $("#show_comment").click(function() {
  //   getComment();
  // });



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
        post += (cur.toButton());
        post += "<br>"


      $("#display").append(post);

  
    });
      $(".js-comment").click(function() {
        getComment(this.id.match(/\d+$/));
      })
  }

  function getComment(target) {
     $.get("/comments/" + target+".json", function(response){
      debugger;
      $("#display_comment" + target.toString()).append(response.body);
    });
  }

  function Comment(d) {

    this.name = d.name;
    this.body = d.body;
    this.id = d.id;
    this.postTitle = d.post.title;
    this.postBody = d.post.body;
    this.toButton = function() {return "<button id='show_comment" + this.id + "' class='js-comment'> Show Comment </button><div id='display_comment" + this.id + "'></div";};

  }



