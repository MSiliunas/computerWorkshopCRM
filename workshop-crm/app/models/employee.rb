# Company's employee
class Employee < ActiveRecord::Base
  attr_reader :firstname, :lastname, :phone, :email
  has_many :order_details

  def initialize(firstname, lastname, phone, email)
    super()
    @firstname = firstname
    @lastname = lastname
    @phone = phone
    @email = email
  end

  def to_s
    firstname + ' ' + lastname + ' ' + phone + ' ' + email
  end
end
