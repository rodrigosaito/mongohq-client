module MongoHQClient

  class Client
    include HTTP

    attr_accessor :apikey

    def initialize(apikey)
      @apikey = apikey
    end

    def databases
      resp = get("databases")

      db_list = []

      raise unless resp.success?

      dbs = JSON.parse resp.body

      dbs.each do |db|
        db_list << Database.new(json: db, apikey: apikey)
      end

      db_list
    end

  end

end
