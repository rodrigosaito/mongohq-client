require 'httparty'
require 'json'

require_relative 'mongohq_client/commons'
require_relative 'mongohq_client/http'
require_relative 'mongohq_client/collection'
require_relative 'mongohq_client/database_details'
require_relative 'mongohq_client/database'
require_relative 'mongohq_client/client'

module MongoHQClient

  def self.from_apikey(apikey)
    Client.new apikey
  end

end
