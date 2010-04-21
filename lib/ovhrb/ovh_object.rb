module OvhRb
  class OvhObject
    include Converter
    
    def initialize(object)
      object.__xmlele.each do |attr, value|
        value = convert_to_ovh_object(value)
        
        attr_name = attr.name.underscore
        instance_variable_set("@#{attr_name}", value)
        unless self.class.method_defined?(attr_name)
          self.class.class_eval do
            define_method(attr_name) { instance_variable_get("@#{attr_name}") }
          end
        end
      end
    end
  end
end
