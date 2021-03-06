# Environment helper class
class EnvHelper
  class << self
    attr_reader :env

    def test_env?
      @env == 'test'
    end

    def enable_test_env
      @env = 'test'
    end

    def enable_prod_env
      @env = 'prod'
    end
  end
end
