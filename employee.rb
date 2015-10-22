# Company's employee
class Employee
  attr_reader :firstname, :lastname, :phone, :email

  def initialize(firstname, lastname, phone, email)
    @firstname = firstname
    @lastname = lastname
    @phone = phone
    @email = email
  end
end
