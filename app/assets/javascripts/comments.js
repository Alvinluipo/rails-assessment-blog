$( document ).ready(function() {
  
  $("#all_comments").click(function(e){

    clearDom();
    getPosts();
    e.preventDefault();
  });

$('form[id="new_comment"]').submit(function(event) {
   event.preventDefault();
   
   var values = $(this).serialize();
   this.reset();
   var posting = $.post('/comments', values);

   posting.done(function(data) {
        var cur = new Comment(data)
        var comment = "<strong>"

          comment += (cur.name).toString();
          comment += "</strong>" 
          comment += "<br>"
          comment += (cur.body).toString();
       



      $("#comments").append(comment);

     // var cur = new Post(data);
     // $(".list").append("<li>" + cur.id + ':' + cur.content + '</li>');
   });
 });


}); 
  // function newPost() {
  //   $('form[id="new_post"]').submit(function(e) {
  //     e.preventDefault();

  //   })
  // }

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
        var cur = new Comment(response)
        var comment = "<li>"

          comment += (cur.name).toString();
          comment += "<br>"
          comment += (cur.body).toString();
          comment += "</li>" 

          comment += "<br>"

      $("#display_comment" + target.toString()).replaceWith(comment);
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



