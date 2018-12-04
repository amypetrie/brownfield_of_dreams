class UserDashboardFacade

  def initialize(token)
    @token = token
  end

  def user_repos
    search_result.map do |repo_data|
      GithubRepo.new(repo_data)
    end
  end

private

  def search_result
    @_search_result ||= service.repos
  end

  def service
    GithubService.new({access_key: @access_key})
  end

end
