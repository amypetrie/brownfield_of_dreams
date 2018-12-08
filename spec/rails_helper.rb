require 'spec_helper'

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)

abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'
require 'vcr'
require 'webmock/rspec'

OmniAuth.config.test_mode = true 
omniauth_hash = {"provider"=>"github",
 "uid"=>"6856230",
 "info"=>
  {"nickname"=>"JSmith23",
   "email"=>"jaystansmith@gmail.com",
   "name"=>"Jimmy Smith",
   "image"=>"https://avatars3.githubusercontent.com/u/6856230?v=4",
   "urls"=>{"GitHub"=>"https://github.com/JSmith23", "Blog"=>""}},
 "credentials"=>{"token"=>"34b73c9cd2085b95d9277a8b8e414ef39514a8e1", "expires"=>false},
 "extra"=>
  {"raw_info"=>
    {"login"=>"JSmith23",
     "id"=>6856230,
     "node_id"=>"MDQ6VXNlcjY4NTYyMzA=",
     "avatar_url"=>"https://avatars3.githubusercontent.com/u/6856230?v=4",
     "gravatar_id"=>"",
     "url"=>"https://api.github.com/users/JSmith23",
     "html_url"=>"https://github.com/JSmith23",
     "followers_url"=>"https://api.github.com/users/JSmith23/followers",
     "following_url"=>"https://api.github.com/users/JSmith23/following{/other_user}",
     "gists_url"=>"https://api.github.com/users/JSmith23/gists{/gist_id}",
     "starred_url"=>"https://api.github.com/users/JSmith23/starred{/owner}{/repo}",
     "subscriptions_url"=>"https://api.github.com/users/JSmith23/subscriptions",
     "organizations_url"=>"https://api.github.com/users/JSmith23/orgs",
     "repos_url"=>"https://api.github.com/users/JSmith23/repos",
     "events_url"=>"https://api.github.com/users/JSmith23/events{/privacy}",
     "received_events_url"=>"https://api.github.com/users/JSmith23/received_events",
     "type"=>"User",
     "site_admin"=>false,
     "name"=>"Jimmy Smith",
     "company"=>nil,
     "blog"=>"",
     "location"=>nil,
     "email"=>nil,
     "hireable"=>nil,
     "bio"=>nil,
     "public_repos"=>35,
     "public_gists"=>11,
     "followers"=>11,
     "following"=>10,
     "created_at"=>"2014-03-05T00:02:12Z",
     "updated_at"=>"2018-12-05T16:40:31Z",
     "private_gists"=>3,
     "total_private_repos"=>0,
     "owned_private_repos"=>0,
     "disk_usage"=>693,
     "collaborators"=>0,
     "two_factor_authentication"=>false,
     "plan"=>{"name"=>"free", "space"=>976562499, "collaborators"=>0, "private_repos"=>0}},
   "all_emails"=>[{"email"=>"jaystansmith@gmail.com", "primary"=>true, "verified"=>true, "visibility"=>"public"}]}}
   OmniAuth.config.add_mock(:github, omniauth_hash)

VCR.configure do |config|
  config.ignore_localhost = true
  config.cassette_library_dir = 'spec/cassettes'
  config.hook_into :webmock
  config.configure_rspec_metadata!
  config.filter_sensitive_data("<YOUTUBE_API_KEY>") { ENV['YOUTUBE_API_KEY'] }
  config.filter_sensitive_data("<GITHUB_API_KEY>") { ENV['github_user_token'] }
  config.allow_http_connections_when_no_cassette = true
end


ActiveRecord::Migration.maintain_test_schema!

Capybara.register_driver :selenium do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome)
end

Capybara.javascript_driver = :selenium_chrome

Capybara.configure do |config|
  config.default_max_wait_time = 5
end

SimpleCov.start "rails"

Shoulda::Matchers.configure do |config|
    config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  config.include FactoryBot::Syntax::Methods

  config.use_transactional_fixtures = true

  config.infer_spec_type_from_file_location!

  config.filter_rails_from_backtrace!
end
