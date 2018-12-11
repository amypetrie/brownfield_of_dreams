class GithubService

  def initialize(filter)
    @filter = filter
  end

  def repos
    get_json("https://api.github.com/user/repos")
  end

  def followers
    get_json("https://api.github.com/user/followers")
  end

  def followed_users
    get_json("https://api.github.com/user/following")
  end

  private

  def get_json(url)
    response = conn.get(url)

    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(:url => 'https://api.github.com') do |faraday|
      # faraday.headers["Authorization"] = ENV["github_user_token"]
      faraday.headers["Authorization"] = "token #{@filter[:access_key]}"
      faraday.adapter  Faraday.default_adapter
    end
  end
end
