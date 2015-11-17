require 'simplecov'
SimpleCov.start

require_relative '../objects/order'
require_relative '../objects/computer'
require_relative '../objects/task'
require_relative '../objects/employee'
require_relative '../objects/client'
require_relative '../objects/discount'
require_relative '../objects/user'
require_relative '../helpers/active_record'
require_relative '../helpers/auth'

RSpec::Matchers.define :be_weekend do
  match do |actual|
    (actual.saturday?) || (actual.sunday?)
  end
end

RSpec::Matchers.define :same_computer do |expected|
  match do |actual|
    expected.serial == actual.serial
  end
end
