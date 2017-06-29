require 'yahoo/api'

# configure
Yahoo::Api.configure do |options|
  options[:appid] = ENV['YAHOO_APPLICATION_ID']
  #options[:affiliate_type] = "vc or yid"
  #options[:affiliate_id] = "your affiliate id"
end