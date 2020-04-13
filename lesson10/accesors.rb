module Accessors
  def attr_accesor_with_history(*attrs)
    attrs.each do |attr|
      attr_name = "@#{attr}".to_sym
      define_method(attr) { instance_variable_get(attr_name) }
      define_method("#{attr}=".to_sym) do |val|
        instance_variable_set(attr_name, val)
        @history_val ||= {}
        @history_val[attr] ||= []
        @history_val[attr] << val
      end
      define_method("#{attr}_history") { @history_val ? @history_val[attr] : [] }
    end
  end

  def strong_attr_accessor

  end
end
