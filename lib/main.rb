require 'ovhrb'
require 'yaml'

config = YAML.load_file("conf/account.yml")

OvhRb::Session.new(config['aurelien']['nic'], config['aurelien']['password']) do |session|
  p session.rps_get_io_stats("r13611.ovh.net", "serviceTime","weekly")
  p session.mom_version
  p session.ticket_list_incidents('')
  p session.billing_invoice_list
  p session.domain_list
  p session.dedicated_list
end

