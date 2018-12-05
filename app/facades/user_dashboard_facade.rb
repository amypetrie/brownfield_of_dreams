class UserDashboardFacade 
  def initialize(user)
    @token = user.github_token
  end

  def search_result 
    @search_result ||= service.get_repos
    binding.pry
  end

  private

  def service
    GithubService.new(@token)
  end 
end 