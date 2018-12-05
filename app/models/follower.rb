class Follower
  attr_reader :name, :url

  def initialize(data)
    binding.pry
    @name = data[:name]
    @url = data[:html_url]
  end

end
