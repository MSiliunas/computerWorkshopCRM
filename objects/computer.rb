require_relative '../helpers/active_record'
require_relative 'client'

# Client's computer
class Computer < ActiveRecord
  attr_reader :specs, :serial
  attr_accessor :client_id
  relation_one :Client, 'client_id', :client
  relation_many :Order, 'order', :orders

  def initialize(serial, specs)
    super()
    @specs = specs
    @serial = serial
  end

  def to_s
    serial
  end
end
