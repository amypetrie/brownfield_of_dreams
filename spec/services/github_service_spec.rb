require 'rails_helper'

describe GithubService do
  it "exists" do
    service = GithubService.new({access_key: ENV["github_user_token"]})

    expect(service).to be_a(GithubService)
  end

  context "instance methods" do
    context "#repos" do
      it "returns an array of repo hashes" do
        VCR.use_cassette("github_service_repo_spec") do
          service = GithubService.new({access_key: ENV["github_user_token"]})

          expect(service.repos).to be_a(Array)
          expect(service.repos.first).to have_key(:html_url)
          expect(service.repos.first).to have_key(:name)
        end
      end
    end

    context "#followers" do
      it "returns an array of follower hashes" do
        VCR.use_cassette("github_service_followers_spec") do
          service = GithubService.new({access_key: ENV["github_user_token"]})

          expect(service.followers).to be_a(Array)
          expect(service.followers.first).to have_key(:login)
          expect(service.followers.first).to have_key(:html_url)
        end
      end
    end

    context "#following" do
      it "returns an array of users who are followed hashes" do
        VCR.use_cassette("github_service_following_spec") do
          service = GithubService.new({access_key: ENV["github_user_token"]})

          expect(service.followed_users).to be_a(Array)
          expect(service.followed_users.first).to have_key(:login)
          expect(service.followed_users.first).to have_key(:html_url)
        end
      end
    end
  end
end
