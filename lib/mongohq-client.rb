require 'httparty'
require 'json'

require 'mongohq-client/commons'
require 'mongohq-client/http'
require 'mongohq-client/plan'
require 'mongohq-client/invoice'
require 'mongohq-client/index'
require 'mongohq-client/document'
require 'mongohq-client/collection'
require 'mongohq-client/database_details'
require 'mongohq-client/database'
require 'mongohq-client/client'

module MongoHQClient

  def self.from_apikey(apikey)
    Client.new apikey
  end

end
