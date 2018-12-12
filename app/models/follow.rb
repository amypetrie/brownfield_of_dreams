class Follow
  attr_reader :name, :url, :uid

  def initialize(data)
    @name = data[:login]
    @url = data[:html_url]
    @uid = data[:id]

  end

  def exists_in_database
    true if existing_user
  end

  def existing_user
    User.find_by(uid: @uid)
  end

end
