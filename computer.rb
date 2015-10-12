# Computer
class Computer
  attr_accessor :client, :specs, :serial

  def initialize(serial, specs, client)
    @specs = specs
    @client = client
    @serial = serial
  end
end
