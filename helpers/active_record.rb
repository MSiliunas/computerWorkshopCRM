require 'yaml'
require_relative 'env_helper'

# Active record design pattern implementation
class ActiveRecord
  attr_reader :id

  def initialize
    class_ref = self.class

    @id = class_ref.new_increment

    class_ref.register_instance(self)
  end

  def delete
    self.class.unregister_instance(self)
    @id = nil
  end

  def ==(other)
    @id == other.id
  end

  class << self
    attr_reader :increment
    attr_reader :instances

    def new_increment
      @increment += 1 if @increment

      @increment ||= 1
    end

    def register_instance(instance)
      @instances ||= {}
      @instances[instance.id] = instance
    end

    def unregister_instance(instance)
      @instances.delete(instance.id)
    end

    def get(id)
      @instances[id]
    end

    def count
      @instances.length
    end

    def ActiveRecord.find_by_helper(instance, filter)
      ok = true
      filter.each do |attr, value|
        ok = false if ok && instance.send(attr) != value
      end
      ok
    end

    def find_by(filter = {})
      return [] if @instances.empty?
      @instances.select do |_id, instance|
        ActiveRecord.find_by_helper(instance, filter)
      end.values
    end

    def relation_one(class_name, attr, method_name)
      define_method method_name do
        Kernel.const_get(class_name).send :get,
                                          (instance_variable_get "@#{attr}")
      end
    end

    def relation_many(class_name, attr, method_name)
      define_method method_name do
        filter = {}
        filter[attr] = self
        Kernel.const_get(class_name).send :find_by, filter
      end
    end

    def dump_filename
      if EnvHelper.test_env?
        'spec/' + 'storage/' + to_s + '.yml'
      else
        'storage/' + to_s + '.yml'
      end
    end

    def dump
      filename = dump_filename
      File.open(filename, 'w') do |file|
        file.write YAML.dump(@instances)
      end
    end

    def load
      filename = dump_filename
      return nil unless File.exist?(filename)

      @instances = YAML.load(File.open(filename))
      @increment =
          @instances.max_by { |key, _value| key }[0] if @instances
    end

    def reset
      @instances = {}
      @increment = 0
    end
  end
end
