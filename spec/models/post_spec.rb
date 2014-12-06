require 'rails_helper'

RSpec.describe Post, :type => :model do
  it "needs to be linked to a user" do
    user = User.create(username: "Testeur", email: "testeur@test.com", password: "password")
    post = Post.new(user: user)
    expect(post.user).to eq(user)
    expect(post.user_id).to eq(user.id)

    expect(post.valid?).to eq(true)
    post.user = nil
    expect(post.valid?).to eq(false)
  end

  #Idem pour hashtag? Need qu'il y en ai forcément un ?
end
