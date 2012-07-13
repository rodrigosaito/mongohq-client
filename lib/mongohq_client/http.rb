module MongoHQClient

  module HTTP

    def get(uri)
      resp = HTTParty.get("#{base_uri}/#{uri}", query: { :_apikey => apikey } )

      JSON.parse(resp.body)
    end

    protected
    def base_uri
      "https://api.mongohq.com"
    end
  end

end
