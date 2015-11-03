require_relative '../helpers/active_record'

# Company's client
class Client < ActiveRecord
  attr_reader :firstname, :phone, :lastname, :email
  relation_many :Computer, 'client', :computers

  def initialize(firstname, lastname, phone, email)
    super()
    @firstname = firstname
    @lastname = lastname
    @phone = phone
    @email = email
  end
end
