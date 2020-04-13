module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_reader :validations

    def validate(name, type, *args)
      @validations ||= []
      @validations << { name: name, type: type, args: args }
    end
  end

  module InstanceMethods
    def validate!

    end

    def valid?
      validate!
      true
    rescue
      false
    end

    protected

    def presence(name, val, _args)
      raise "#{name} is not present" if val.nil? || val == ''
    end

    def format(name, val, format)
      raise 'Wrong format!' if val !~ format
    end

    def type(name, val, type)
      raise 'Class mismatch!' if val.class != type
    end
  end
end
