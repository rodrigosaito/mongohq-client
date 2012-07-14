module MongoHQClient

  class Database
    include Commons
    include HTTP

    def details
      json = get("databases/#{name}")

      DatabaseDetails.new json: json
    end

    def collections
      json = get("databases/#{name}/collections")

      collections = []

      json.each do |col|
        collections << Collection.new(json: col, apikey: @apikey)
      end

      collections
    end

    def collection(col_name)
      json = get("databases/#{name}/collections/#{col_name}")

      Collection.new(json: json, database: name)
    end

  end
end
