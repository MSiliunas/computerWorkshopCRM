require 'yaml'

# Active record design pattern implementation
class ActiveRecord
  attr_reader :id

  def initialize
    @id = self.class.new_increment

    self.class.register_instance(self)
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
      @increment += 1 unless @increment.nil?

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

    def find_by(filter = {})
      return [] if @instances.nil?
      @instances.select do |_id, instance|
        ok = true
        filter.each do |attr, value|
          ok = false if ok && instance.send(attr) != value
        end
        ok
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
      'storage/' + to_s + '.yml'
    end

    def dump(debug = false)
      filename = debug ? 'spec/' + dump_filename : dump_filename
      File.open(filename, 'w') do |file|
        file.write YAML.dump(@instances)
      end
    end

    def load(debug = false)
      filename = debug ? 'spec/' + dump_filename : dump_filename
      return nil unless File.exist?(filename)

      @instances = YAML.load(File.open(filename))
    end

    def reset
      @instances = {}
    end
  end
end
