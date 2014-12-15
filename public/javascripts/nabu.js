// JavaScript Document
var finish = true;
var finish2 = true;
var last_id= 0;
var id_post_new= 0;
var last_user= 0;
var id_user_new= 0;

var Nabu = {
    defaults: {

    },

    init: function (options) {
        this.params = $.extend(this.defaults, options);
    },
	
	bookmark:function(link, id, state){

		if(state == "0")
			url = "/posts/add_bookmark/"+id;
		else if(state == "1")
			url = "/posts/remove_bookmark/"+id;
		
		$.ajax({
			url:url,
			method:"get",
		})
		.success(function(response){
			var $bookmarks_number = $('.bookmarks-number .follow-number');
			var bookmarks_number = parseInt($bookmarks_number.text());
			if(response == "0"){
				$(link).children().attr("class", "js-fav fav add-fav");
				$(link).data("state", "0");
				if ($('.current_user .bookmarks-number').length > 0) $bookmarks_number.text(bookmarks_number - 1);
			}else if(response == "1"){
				$(link).children().attr("class", "js-fav fav remove-fav nice-anim");
				$(link).data("state", "1");
				if ($('.current_user .bookmarks-number').length > 0) $bookmarks_number.text(bookmarks_number + 1);
			
			}
		}).error(function(e){
			console.log(e);
		})
		
	},
	
	repost:function(link, id, state){
		if(state == "0")
			url = "/posts/add_repost/"+id;
		else if(state == "1")
			url = "/posts/remove_repost/"+id;
		
		$.ajax({
			url:url,
			method:"get",
		})
		.success(function(response){
			var $posts_number = $('.posts-number .follow-number');
			var posts_number = parseInt($posts_number.text());
			if(response == "0"){
				$(link).children().attr("class", "js-repost-icon repost-icon do-repost");
				$(link).data("state", "0");
				if ($('.current_user .posts-number').length > 0) $posts_number.text(posts_number - 1);
			}else if(response == "1"){
				$(link).children().attr("class", "js-repost-icon repost-icon undo-repost nice-anim");
				$(link).data("state", "1");
				if ($('.current_user .posts-number').length > 0) $posts_number.text(posts_number + 1);
				
			}
		}).error(function(e){
			console.log(e);
		})

	},
	
	getOldPosts:function(id_post){
		
		//console.log("id_post "+id_post);
		username = $("div.post-feed").last().data("username");
		

		if(url.indexOf("bookmarks")>0)
			url = "/user/bookmarks/"+username+"/"+id_post;
		else if(url.indexOf("user")>0)
			url = "/user/"+username+"/"+id_post;
		else
			url = "/feed/"+id_post;

		console.log("url"+url);

		$.ajax({
				url:url,
				method:"get",
			})
			.success(function(response){
				$(".post-loader").addClass("transparent");
				if(response.length > 1)
					$("#zone_post").append(response);
				finish = true;
				last_id = id_post_new;	
			})
		
	},

	getMoreSearch:function(search, id_last, type){
		finish=false;
		finish2 = false;

		if (type == "hash"){
			search = search.replace("#","%23");
			url = '/search/by_hash/'+search+"/"+id_last;
		}
		else if (type == "users") {
			url = '/search/by_users/'+search+"/"+id_last;
		}
		else{
  			url = '/search/by_posts/'+search+"/"+id_last;
		}

		$.ajax({
				url:url,
				method:"get",
			})
			.success(function(response){
				console.log(response);
				if(response.length > 1){
					if (type =="users"){
			  			$("#div-user").append(response);
			  			last_user = id_user_new;
			  			
					}
			  		else{
			  			$("#div-post").append(response);
			  			last_id = id_post_new;
			  		}
					
				}
				else{
					if (type =="users"){
			  			$(".btn-user").addClass("transparent");
					}
			  		else{
			  			$(".btn-post").addClass("transparent");
			  		}

				}
				finish = true;
				finish2 = true;
				$("#loader-user").addClass("transparent");
				$("#loader-post").addClass("transparent");	
					
			})
			.error(function(e){
				console.log(e);
			})
			
	},
	
	follow:function(link, id, state){
		//state 0 <=> "I want "unfollow" U" 
		//state 1 <=> "I want "follow" U" 
		if(state == "0")
			url = "/users/unfollow/"+id;
		else if(state == "1")
			url = "/users/follow/"+id;
		
		$.ajax({
				url:url,
				method:"get",
			})
			.success(function(response){
				var $followings_number = $('#stats-following .follow-number');
				var followings_number = parseInt($followings_number.text());
				if(response == "0"){
					if( $(".sugg-follow")[0] ) {
						$(link).html("+");
						$(link).removeClass("nice-anim");
					} else {
						$(link).html("Suivre");
					}
					$(link).data("state", "1");
					$followings_number.text(followings_number - 1);
				}
				else if(response == "1"){
					if( $(".sugg-follow")[0] ) {
						$(link).addClass("nice-anim");
						$(link).html("-");
					} else {
						$(link).html("Ne plus suivre");
					}
					$(link).data("state", "0");
					$followings_number.text(followings_number + 1);
				}
				
			}).error(function(e){
				console.log(e);
			})
		
		},
	getSuggestPosts:function(){
		
		$.ajax({
			url:"/suggest/suggestposts",
			method:"get",
		})
		.success(function(data){
			$("#suggest_articles").html(data);
		})
		
		
	},
	
	getSuggestUsers:function(){
		//console.log('OK');
		$.ajax({
			url:"/suggest/suggestusers",
			type:"get",
		})
		.success(function(data){
			$("#suggest_follow").html(data);
		})
		
		
	},
			
	
}


Nabu.init();

// FOLLOW
$(".follow-container").on("click","a.js-follow", function(e){
	e.preventDefault();
	id = $(this).data("id");
	state = $(this).data("state");
	Nabu.follow(this, id, state);
});

//SEARCH
$('.btn-load-more').on('click',function(e){
	
	e.preventDefault();

	type = $(this).data("type");
	search = $(this).data("search");
	if(search.length < 1)
		search = "--";

	console.log(search);
	id_post_new = parseInt($("div.post-feed").last().data("idpost"));
	id_user_new = parseInt($("div.user").last().data("iduser"));
	

	if((type == "posts"|| type == "hash") && finish && (id_post_new != last_id)){	
		$("#loader-post").removeClass("transparent");	
			Nabu.getMoreSearch(search, id_post_new, type);
		}
	else if(type == "users" && finish2 && (id_user_new != last_user)){	
		$("#loader-user").removeClass("transparent");	
			Nabu.getMoreSearch(search, id_user_new, type);
		}

		
});

// REPOST
$(".js-repost").on("click", function(e){
	e.preventDefault();
	var link = this;
	var id = $(this).data("id");
	var state = $(this).data("state");

	Nabu.repost(link, id, state);
});

//BOOKMARKS
$(".js-bookmark").on("click", function(e){
	e.preventDefault();
	var link = this;
	var id = $(this).data("id");
	var state = $(this).data("state");
	
	Nabu.bookmark(link, id, state);
});

	//suggestions
$('#suggest_articles_button').on('click',function(e){
	e.preventDefault();
	console.log("click");
	
	Nabu.getSuggestPosts();

})

$('#suggest_follows_button').on('click',function(e){
	e.preventDefault();
	
	Nabu.getSuggestUsers();

})

// INFINITE SCROLL ---FEED - PROFILE - BOOKMARKS ---
$(window).scroll(function(){
	url = window.location.href; 

	if(url.indexOf("bookmarks")<0 && url.indexOf("user")<0){
		id_post_new = $("div.post-feed").last().data("createdat");
	}
	else
		id_post_new = parseInt($("div.post-feed").last().data("idpost"));

		//console.log(id_post_new+" "+last_id);
	if($("#zone_post")&&($(window).scrollTop() + $(window).height())>=(0.8*$(document).height())){	
		if(finish && (id_post_new != last_id)){		
			finish = false;	
			Nabu.getOldPosts(id_post_new);
		}
	}
	
});

/*------INTERFACE ------*/

$('input[id="post_url"]').on('focus',function(){
	$('#form-extended').fadeIn(400);
});
$('input[id="post_url"]').on('blur',function(){
	if( !$(this).val() ) {
		$('#form-extended').fadeOut(400);
	}
});
$('input[name="name"]').focusout(function() {
      $('.users-result').hide(200);
 });
 $('input[name="name"]').focus(function() {
    $('.users-result').show(200);
});
// follow lists
$('#sidebar #stats-followers, .followers .close').on('click',function(e){
	e.preventDefault();
	//$('#sidebar .content:nth-child(2)').toggle(200);
	if($('.following').is(':visible')){$('.following').hide()}
	$('.followers').fadeToggle(200);
});
$('#sidebar #stats-following, .following .close').on('click',function(e){
	e.preventDefault();
	//$('#sidebar .content:nth-child(2)').toggle(200);
	if($('.followers').is(':visible')){$('.followers').hide()}
	$('.following').fadeToggle(200);
});


window.setTimeout(function() {
  $(".alert").fadeTo(500, 0).slideUp(500, function(){
      $(this).remove();
  });
}, 3000);