# Customer entity
class Client < ActiveRecord::Base
  has_many :orders, inverse_of: :client
  has_many :computers, inverse_of: :client
  validates :firstname, presence: true
  validates :lastname, presence: true
  validates :phone, presence: true, length: { minimum: 5 }
  validates :email, presence: true

  def to_s
    firstname + ' ' + lastname + ' ' + phone + ' ' + email
  end
end
