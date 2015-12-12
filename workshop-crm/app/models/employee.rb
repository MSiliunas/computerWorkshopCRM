# Company's employee
class Employee < ActiveRecord::Base
  has_many :order_details

  def to_s
    firstname + ' ' + lastname + ' ' + phone + ' ' + email
  end
end
