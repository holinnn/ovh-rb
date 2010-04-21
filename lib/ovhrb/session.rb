module OvhRb
  class Session
    include SoapRequestHandler

    def initialize(nic, password, language = 'en', mulisession = true, wsdl = "https://www.ovh.com/soapi/soapi-re-1.9.wsdl")
      @nic = nic
      @password = password
      @language = language
      @multisession = mulisession

      self.soap_object = SOAP::WSDLDriverFactory.new(wsdl).create_rpc_driver
      @session_id = login(@nic, @password, @language, @multisession)
      
      if block_given?
        begin
          yield self
#        ensure
#          logout
        end
      end
    end
  end
end
