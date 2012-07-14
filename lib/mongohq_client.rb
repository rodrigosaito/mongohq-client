require 'httparty'
require 'json'

require 'mongohq_client/commons'
require 'mongohq_client/http'
require 'mongohq_client/invoice'
require 'mongohq_client/index'
require 'mongohq_client/document'
require 'mongohq_client/collection'
require 'mongohq_client/database_details'
require 'mongohq_client/database'
require 'mongohq_client/client'

module MongoHQClient

  def self.from_apikey(apikey)
    Client.new apikey
  end

end
