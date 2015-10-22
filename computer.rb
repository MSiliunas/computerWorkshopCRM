# Client's computer
class Computer
  attr_reader :specs, :serial, :owner

  def initialize(serial, specs, owner)
    @specs = specs
    @serial = serial
    @owner = owner
  end
end
