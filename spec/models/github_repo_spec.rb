require 'rails_helper'

RSpec.describe GithubRepo, type: :model do
  repo = GithubRepo.new({name: "Repo", html_url: "website.com"})

  it 'it exists' do
    expect(repo).to be_a(GithubRepo)
  end

  it 'has a name' do
    expect(repo.name).to eq "Repo"
  end

  it 'has a url' do
    expect(repo.url).to eq "website.com"
  end

end
