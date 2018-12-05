require 'rails_helper'

describe GithubService do
  it "exists" do
    service = GithubService.new({access_key: ENV["github_user_token"]})

    expect(service).to be_a(GithubService)
  end

  context "instance methods" do
    context "#repos" do
      it "returns a hash" do
        VCR.use_cassette("github_service_spec") do
          service = GithubService.new({access_key: ENV["github_user_token"]})


          expect(service.repos).to be_a(Array)
          expect(service.repos.first).to have_key(:html_url)
          expect(service.repos.first).to have_key(:name)
        end
      end
    end
  end
end
