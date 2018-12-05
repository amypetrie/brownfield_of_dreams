class UserDashboardFacade

  def initialize(user) #change this to take in user
    # @github_token = github_token
    @user = user
  end

  def user_repos(count)
    repo_search_result[0...count].map do |repo_data|
      GithubRepo.new(repo_data)
    end
  end

  def followers(count)
    # follower_search_result[0...count].map do |follower_data|
    #   Follower.new(follower_data)
    # end
  end

private
  attr_reader :user

  def repo_search_result
    @repo_search_result ||= service.repos
  end

  def follower_search_result
    @follower_search_result ||= service.followers
  end

  def service
    #just pass in the token as a method on the user - user.token
    GithubService.new({access_key: user.token})
  end

end
