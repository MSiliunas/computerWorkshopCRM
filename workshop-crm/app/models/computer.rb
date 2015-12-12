class Computer < ActiveRecord::Base
  belongs_to :client, inverse_of: :computers
  has_many :order_details

  def to_s
    serial
  end
end
