require "spec_helper"

RSpec.describe User, :type => :model do

  it "requires a name, an email, a password (more then 8 characters)" do
    user = User.new
    expect(user.valid?).to eq(false)

    user.username = "test"
    expect(user.valid?).to eq(false)

    user.email = "test@domain.com"
    expect(user.valid?).to eq(false)

    user.password = "pass"
    expect(user.valid?).to eq(false)

    user.password = "password"
    expect(user.valid?).to eq(true)
  end

  it "can be saved" do
    user = User.create(username: "test", email: "test@domain.com", password: "password")
    user.save!

    found = User.last
    expect(found.username).to eq("test")
    expect(found.email).to eq("test@domain.com")
  end

  it "requires a somewhat valid email" do
    user = User.new(username: "test", password: "password")
    expect(user.valid?).to eq(false)

    user.email = "test"
    expect(user.valid?).to eq(false)

    user.email = "test@domain"
    expect(user.valid?).to eq(false)

    user.email = "test@domain.com"
    expect(user.valid?).to eq(true)
  end

  it "is impossible to add the same email twice" do
    user = User.create(username: "test", password: "password", email: "test@domain.com")
    expect(user.valid?).to eq(true)

    other_user = User.create(username: "test", password: "password", email: "test@domain.com")
    expect(other_user.valid?).to eq(false)
  end

  it "is impossible to add the same email twice" do
    user = User.create(username: "test", password: "password", email: "testa@domain.com")
    expect(user.valid?).to eq(true)

    other_user = User.create(username: "test", password: "password", email: "testb@domain.com")
    expect(other_user.valid?).to eq(false)
  end
end
