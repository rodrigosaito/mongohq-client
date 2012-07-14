module MongoHQClient

  module HTTP

    def get(uri)
      raise "Invalid apikey" unless apikey
      resp = HTTParty.get("#{base_uri}/#{uri}", query: { :_apikey => apikey } )

      #TODO error handling

      JSON.parse(resp.body)
    end

    protected
    def base_uri
      "https://api.mongohq.com"
    end
  end

end
