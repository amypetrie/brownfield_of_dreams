class Follow
  attr_reader :name, :url

  def initialize(data)
    @name = data[:login]
    @url = data[:html_url]
    @uid = data[:id]
  end

end
