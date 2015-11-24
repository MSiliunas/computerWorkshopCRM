require_relative '../helpers/active_record'

# Company's employee
class Employee < ActiveRecord
  attr_reader :firstname, :lastname, :phone, :email
  relation_many :Order, 'employee', :orders

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
