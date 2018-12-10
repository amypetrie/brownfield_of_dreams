require 'rails_helper'

RSpec.describe Follow, type: :model do
  follow = Follow.new({login: "Follow 1", html_url: "www.google.com", uid: "1"})

  it "follow exists" do
    expect(follow).to be_a(Follow)
  end

  it "has a login" do
    expect(follow.name).to eq "Follow 1"
  end

  it "has a url" do
    expect(follow.url).to eq "www.google.com"
  end
end
