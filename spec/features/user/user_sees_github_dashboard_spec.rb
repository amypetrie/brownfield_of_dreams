require 'rails_helper'

feature 'A logged in user can see github repos' do
  
  it "can visit the dasbbaord" do
    user = create(:user)
    
    response = JSON.parse(File.read("./spec/fixtures/user_github_repos.json"), symbolize_names: true)
    stub_request(:get, "https://api.github.com/user/repos")
      .with(query: { access_token: user.github_token })
      .to_return(body: response.to_json)
        
    
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit dashboard_path

    # Then I should see a section for "Github"
    expect(page).to have_content("Github")
    expect(page).to have_css(".github_repo", count: 5)
    # And under that section I should see a list of 5 repositories
    within(".github_repos_list") do
      response.first(5).each do |hash|
        link = find_link(hash[:name])
        expect(link[:href]).to eq(hash[:html_url])
        expect(link[:target]).to eq('_blank')     
      end
    end
  end
end



