class UserDashboardFacade

  def initialize(user) #change this to take in user
    # @github_token = github_token
    @user = user
  end

  def user_repos(count)
    search_result[0...count].map do |repo_data|
      GithubRepo.new(repo_data)
    end
  end

  def user_name
    # user.name
  end

private
  attr_reader :user

  def search_result
    @_search_result ||= service.repos
  end

  def service
    #just pass in the token as a method on the user - user.token
    GithubService.new({access_key: user.token})
  end

end
