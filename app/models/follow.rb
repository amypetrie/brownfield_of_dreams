class Follow
  attr_reader :name, :url, :uid

  def initialize(data)
    @name = data[:login]
    @url = data[:html_url]
    @uid = data[:id]
  end

  def user_exists
    true if User.find_by(uid: @uid)
  end
  
end
