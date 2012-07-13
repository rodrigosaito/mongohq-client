module MongoHQClient

  class Database
    include Commons
    include HTTP

    def details
      resp = get("database/#{name}")

      DatabaseDetails.new json: JSON.parse(resp.body)
    end

    def collections
      resp = get("database/#{name}/collections")

      collections = []

      JSON.parse(resp).each do |col|
        collections << Collection.new(json: col, apikey: @apikey)
      end

      collections
    end

    def collection(col_name)
      resp = get("database/#{name}/collection/#{col_name}")

      Collection.new(json: JSON.parse(resp.body))
    end

  end
end
