var User = {
    defaults: {
		divNbFollowers: '#nb_followers',
		divNbFollowing: '#nb_following',
		divNbPosts: '#nb_posts',
		divNbBadges: '#nb_badges',
		divCount: '#count',
		divCatPostsUser:'#post_cat_user',
		divFollowers:'',
		divFollowing:'',
		buttonFollow:'.btn_follow',

    },

    init: function (options) {
        this.params = $.extend(this.defaults, options);
    },

    getUsers:function(){
    	$.ajax({
					url:"users/show",
					method:"get",

				})
				.success(function(data){
					console.log(data);
					$("#test").html(data);
				});

   	},
	
	getUserId:function(){
		
	},
	
	getStateFollow:function(){

	},
	
	getUserData:function(){
		
	},
	
	getMonthCount:function(){

	},
	getGraphProfile:function(cat){

	},
	
	
	getCatPostsUser:function(){

	},
	
	getUserBadges:function(){
		
	},
	
	getUserObjectives:function(){

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
				console.log(response);
				//response 0 <=> "I don't follow U"
				//response 1 <=> "I follow U *sing*"  
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
		
		}
			
	
}


User.init();
//User.getUsers();

//alert("ok");


// #test is just before the footer !
$(".follow-container").on("click","a.js-follow", function(e){
	e.preventDefault();
	id = $(this).data("id");
	state = $(this).data("state");

	User.follow(this, id, state);
})

