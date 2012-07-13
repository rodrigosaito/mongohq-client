module MongoHQClient
  module Commons
    def method_missing(method, *args)
      attribute = method.to_s
      if (attribute.to_s.end_with? '?')
        attribute = attribute.to_s[0..-2]
      end

      super.method_missing(method, *args) unless @json.has_key? attribute

      return @json["#{attribute}"]
    end

    def initialize(params = {})
      @json = JSON.parse(params[:json])
      @apikey = params[:apikey]
    end

  end
end
