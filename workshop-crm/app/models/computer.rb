class Computer < ActiveRecord::Base
  belongs_to :client, inverse_of: :computers
  attr_reader :specs, :serial

  def initialize(serial, specs)
    super()
    @specs = specs
    @serial = serial
  end

  def to_s
    serial
  end
end
