module OvhRb
  module SoapRequestHandler
    include Converter
    
    attr_accessor :soap_object, :session_id

    def method_missing(name, *args)
      soap_method_name = name.to_s.camelize(:lower)

      if soap_object.respond_to? soap_method_name
        self.class.class_eval do
          define_method_used = "define_#{(soap_method_name=="login"? "login" : "soapi")}_method"
          send(define_method_used, name, soap_method_name)
        end
        send(name, *args)
      else
        super
      end
    end

    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      protected
      def define_login_method(name, soap_method_name)
        define_method(name) do |*method_args|
          soap_object.send(soap_method_name, *method_args)
        end
      end

      def define_soapi_method(name, soap_method_name)
        define_method(name) do |*method_args|
          soap_response = nil
          soap_response = begin
            soap_object.send(soap_method_name, *method_args.insert(0, session_id))
          rescue ArgumentError => e
            if e.to_s =~ /for 0/
              soap_object.send(soap_method_name)
            else
              raise e
            end
          end
          convert_to_ovh_object(soap_response) if soap_response
        end
      end
    end
  end
end
