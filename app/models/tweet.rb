class Tweet
  ALL = []

  def initialize(user, status)
    @user = user
    @status = status
    ALL << self
  end

  def user
    @user
  end

  def status
    @status
  end

  def self.all
    ALL
  end
end