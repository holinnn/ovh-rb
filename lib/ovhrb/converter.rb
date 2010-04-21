# To change this template, choose Tools | Templates
# and open the template in the editor.

module OvhRb
  module Converter
    protected
    def convert_to_ovh_object(object)
      if object.public_methods(false).size == 8 && object.respond_to?(:raw)
        object.raw
      elsif object.is_a? String
        object
      elsif object.is_a? SOAP::Mapping::Object
        OvhObject.new(object)
      elsif object.is_a? Array
        object.collect { |e| convert_to_ovh_object(e) }
      else
        object
      end
    end
  end
end
