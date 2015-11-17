require 'digest'

# User account class
class User
  attr_accessor :username, :password

  def password=(plain)
    @password = Digest::SHA2.hexdigest plain
  end
end
