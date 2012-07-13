module MongoHQClient

  module HTTP

    def get(uri)
      resp = HTTParty.get("#{base_uri}/#{uri}", query: { :_apikey => apikey } )
    end

    protected
    def base_uri
      "https://api.mongohq.com"
    end
  end

end
