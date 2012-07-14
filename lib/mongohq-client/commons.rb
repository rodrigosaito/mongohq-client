module MongoHQClient
  module Commons
    def method_missing(method, *args)
      attribute = method.to_s
      if (attribute.to_s.end_with? '?')
        attribute = attribute.to_s[0..-2]
      end

      super.method_missing(method, *args) unless json_hash.has_key? attribute

      return json_hash["#{attribute}"]
    end

    def initialize(params = {})
      raise "Invalid json" unless params[:json].is_a? Hash
      @params = params
    end

    protected
    def json_hash
      @params[:json]
    end

    def apikey
      @params[:apikey]
    end

  end
end
