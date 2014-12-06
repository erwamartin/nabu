require 'rails_helper'

RSpec.describe PostsController, :type => :controller do

  render_views

  # describe "GET index" do
  #   it "displays a list of posts with some author details" do
  #     eileen = User.create(name: "Eileen #{rand(1000)}", email: "Eileen@rs.com")
  #     benson = User.create(name: "Benson #{rand(1000)}", email: "benson@rs.com")

  #     a_post = Post.create(user: eileen, message: "Hello")
  #     an_unpublished_post = Post.create(user: eileen, message: "Not published!", published: false)
  #     a_post_again = Post.create(user: eileen, message: "Hello all!")
  #     benson_post = Post.create(user: benson, message: "And another one #{rand 1000}")

  #     get :index
  #     expect(response).to have_http_status(:success)

  #     expect(response.body).to include("#{eileen.name} wrote #{a_post.message}")
  #     expect(response.body).to include("#{eileen.name} wrote #{a_post_again.message}")
  #     expect(response.body).to include("#{benson.name} wrote #{benson_post.message}")
  #     expect(response.body).to_not include("Not published")
  #   end

  #   it "only display published posts" do
  #     eileen = User.create(name: "Eileen #{rand(1000)}", email: "Eileen@rs.com")
  #     a_post = Post.create(user: eileen, message: "Hello")
  #     an_unpublished_post = Post.create(user: eileen, message: "Not published!", published: false)

  #     get :index
  #     expect(response).to have_http_status(:success)

  #     expect(response.body).to include("#{eileen.name} wrote #{a_post.message}")
  #     expect(response.body).to_not include("Not published")
  #   end
  # end

  describe "GET new" do
    it "displays a form to create a new post" do
      get :new

      expect(response).to have_http_status(:success)
      expect(response.body).to include("Create a new post!")
    end
  end

  describe "GET show" do
    it "displays a post" do
      user = User.create(username: "Testeur #{rand 1000}", email: "Testeur@rs.com", password:"test")
      my_post = Post.create(user: user, content: "Showing the post #{rand 1000}")

      get "show", id: my_post.id

      expect(response.body).to include("Posté par #{user.username}")
      expect(response.body).to include(my_post.content)
    end
  end

  describe "POST create" do
    it "creates a new post" do
      user = User.create(username: "Testeur", email: "Testeur@rs.com", password:"test")

      post :create, post: { user_id: user.id, content: "Hello yall!", hashtag_id: 1 }
      expect(response).to redirect_to(posts_path)

      last_post_created = Post.last
      expect(last_post_created.content).to eq("Hello yall!")
      expect(last_post_created.hashtag_id).to eq(1)
      expect(last_post_created.user.id).to eq(user.id)
    end

    # it "fails gracefuly if there is a validation error" do
    #   user = User.create(name: "Testeur", email: "Testeur@rs.com", password:"test")

    #   post :create, post: { user_id: nil, message: "Hello yall!" }

    #   expect(response.body).to include("User can&#39;t be blank")
    #   expect(Post.count).to eq(0)
    # end
  end
end
