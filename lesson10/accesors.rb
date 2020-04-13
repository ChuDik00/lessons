# frozen_string_literal: true

module Accessors
  # rubocop:disable Metrics/MethodLength
  def attr_accesor_with_history(*attrs)
    attrs.each do |attr|
      attr_name = "@#{attr}".to_sym
      define_method(attr) { instance_variable_get(attr_name) }
      define_method("#{attr}=".to_sym) do |val|
        instance_variable_set(attr_name, val)
        @history ||= {}
        @history[attr] ||= []
        @history[attr] << val
      end
      define_method("#{attr}_history") { @history ? @history[attr] : [] }
    end
  end
  # rubocop:enable Metrics/MethodLength

  def strong_attr_accessor(attr, attr_class)
    attr_name = "@#{attr}".to_sym
    define_method(attr) { instance_variable_get(attr_name) }
    define_method("#{attr}=".to_sym) do |val|
      raise 'Type mismatch!' unless val.is_a?(attr_class)

      instance_variable_set(attr_name, val)
    end
  end
end
