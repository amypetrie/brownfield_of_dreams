class UserDashboardFacade

  def initialize(user) #change this to take in user
    @user = user
  end

  def user_repos(count)
    repo_search_result[0...count].map do |repo_data|
      GithubRepo.new(repo_data)
    end
  end

  def followers(count)
      follower_search_result[0...count].map do |follower_data|
        Follower.new(follower_data)
    end
  end

  def followed_users
    following_search_result.map do |follow_data|
      Follow.new(follow_data)
    end
  end

  def user_friends
    # binding.pry
    @user.friended_users
  end

private
  attr_reader :user

  def repo_search_result
    @repo_search_result ||= service.repos
  end

  def follower_search_result
    @follower_search_result ||= service.followers
  end

  def following_search_result
    @following_search_result ||= service.followed_users
  end

  def service
    #just pass in the token as a method on the user - user.token
    GithubService.new({access_key: user.token})
  end

end
