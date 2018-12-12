require 'rails_helper'

RSpec.describe Follower, type: :model do
  follower = Follower.new({login: "Follower 1", html_url: "www.google.com", uid: "2"})

  it "follower exists" do
    expect(follower).to be_a(Follower)
  end

  it "has a login" do
    expect(follower.name).to eq "Follower 1"
  end

  it "has a url" do
    expect(follower.url).to eq "www.google.com"
  end
end
