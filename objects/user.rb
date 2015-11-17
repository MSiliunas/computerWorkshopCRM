require 'digest'

# User account class
class User
  attr_reader :username, :password

  def password=(plain)
    @password = Digest::SHA2.hexdigest plain
  end
end
