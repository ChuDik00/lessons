# frozen_string_literal: true

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
      self.class.instance_variable_get(:@validations).each do |validation|
        name = validation[:name]
        val = instance_variable_get("@#{name}".to_sym)
        arg = validation[:args][0]
        send validation[:type].to_sym, name, val, arg
      end
    end

    def valid?
      validate!
      true
    rescue StandardError
      false
    end

    protected

    def presence(name, val, _args)
      raise "#{name} could not be empty." if val.nil? || val == ''
    end

    def format(_name, val, format)
      raise 'Wrong format!' if val !~ format
    end

    def type(_name, val, type)
      raise 'Class mismatch!' if val.class != type
    end

    def zero(name, val, _args)
      raise "#{name} could not be empty." if val.zero?
    end
  end
end
