require 'rails_helper'
begin
  User
rescue
  User = nil
end

RSpec.describe User, :type => :model do

  describe "password encryption" do
    it "does not save passwords to the database" do
      User.create!(username: "jack_bruce", password: "abcdef")
      user = User.find_by_username("jack_bruce")
      expect(user.password).not_to be("abcdef")
    end

    it "encrypts the password using BCrypt" do
      expect(BCrypt::Password).to receive(:create)
      User.new(username: "jack_bruce", password: "abcdef")
    end

  end

  describe "session token" do
    it "assigns a session_token if one is not given" do
      jack = User.create(username: "jack_bruce", password: "abcdef")
      expect(jack.session_token).not_to be_nil
    end
  end

  describe "credentials check" do
    user = User.create(username: "brucewayne", password: 'iambatman')

    it "returns a user if valid credentials" do
      expect(user.find_by_credentials('brucewayne', 'iambatman')).to eq(user)
    end

    it "returns nil if user if invalid" do
      expect(user.find_by_credentials('brucewayne', 'iamsuperman')).to eq(nil)
    end

    it "returns nil if user does not exist" do
      expect(user.find_by_credentials('superman', 'iamsuperman')).to eq(nil)
    end
  end

  it { should validate_length_of(:password).is_at_least(6) }
  it { should validate_presence_of(:username) }
  it { should validate_presence_of(:password_digest) }
  it { should have_many(:comments) }
  it { should have_many(:goals) }
end
