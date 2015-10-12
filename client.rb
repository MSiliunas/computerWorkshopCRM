# Client
class Client
  attr_accessor :address, :firstname, :phone, :lastname, :email

  def initialize(firstname, lastname, phone, email, address)
    @firstname = firstname
    @lastname = lastname
    @phone = phone
    @email = email
    @address = address
  end
end
