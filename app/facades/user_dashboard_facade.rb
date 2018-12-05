class UserDashboardFacade

  def initialize(github_token)
    @github_token = github_token
  end

  def user_repos(count)
    search_result[0...count].map do |repo_data|
      GithubRepo.new(repo_data)
    end
  end

private

  def search_result
    @_search_result ||= service.repos
  end

  def service
    GithubService.new({access_key: @github_token})
  end

end
