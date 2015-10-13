# Employee
class Employee
  attr_accessor :firstname, :lastname, :phone, :email

  def initialize(firstname, lastname, phone, email)
    @firstname = firstname
    @lastname = lastname
    @phone = phone
    @email = email
  end
end
