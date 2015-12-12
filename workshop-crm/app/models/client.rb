# Customer entity
class Client < ActiveRecord::Base
  has_many :orders, inverse_of: :client
  has_many :computers, inverse_of: :client
  attr_reader :firstname, :phone, :lastname, :email

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
