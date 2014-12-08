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
	
	follow:function(btn, id, state){
		//state 0 <=> "I want "unfollow" U" 
		//state 1 <=> "I want "follow" U" 
		if(state == "0")
			url = "users/unfollow/"+id;
		else if(state == "1")
			url = "users/follow/"+id;
		
		$.ajax({
				url:url,
				method:"get",
			})
			.success(function(response){
				console.log(response);
				//response 0 <=> "I don't follow U"
				//response 1 <=> "I follow U *sing*"  
				if(response == "0"){
					$(btn).html("follow");
					$(btn).data("state", "1");
				}
				else if(response == "1"){
					$(btn).html("unfollow");
					$(btn).data("state", "0");
					
				}

				console.log($(btn).data("state"));
				
			})
		
		}
			
	
}


User.init();
//User.getUsers();


// #test is just before the footer !
$(".follow-div").on("click","button", function(){

	id = $(this).data("id");
	state = $(this).data("state");
	//console.log(id);

	User.follow(this, id, state);
})

