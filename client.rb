# Company's client
class Client
  attr_reader :firstname, :phone, :lastname, :email

  def initialize(firstname, lastname, phone, email)
    @firstname = firstname
    @lastname = lastname
    @phone = phone
    @email = email
  end
end
