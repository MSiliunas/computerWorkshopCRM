# Company's employee
class Employee < ActiveRecord::Base
  has_many :order_details
  validates :firstname, presence: true
  validates :lastname, presence: true
  validates :phone, presence: true, length: { minimum: 5 }
  validates :email, presence: true

  def to_s
    firstname + ' ' + lastname + ' ' + phone + ' ' + email
  end
end
