class User < ActiveRecord::Base
  def self.authenticate(u, p)
    user = User.find_by(username: u) || nil
    return false if user.nil?
    user.password == p
  end
end
