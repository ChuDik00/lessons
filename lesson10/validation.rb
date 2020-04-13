module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  def validate(name, type, *args)

  end
end
