class Follow
  attr_reader :name, :url

  def initialize(data)
    @name = data[:login]
    @url = data[:html_url]
    @uid = data[:id]
  end

  def finder 
    true if User.find_by(uid: @uid)
  end 

end
