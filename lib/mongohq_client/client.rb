module MongoHQClient

  class Client
    include HTTP

    attr_accessor :apikey

    def initialize(apikey)
      @apikey = apikey
    end

    def databases
      json = get("databases")

      db_list = []

      json.each do |db|
        db_list << Database.new(json: db, apikey: apikey)
      end

      db_list
    end

    def invoices
      json = get("invoices")

      invoices = []

      json.each do |invoice|
        invoices << Invoice.new(json: invoice)
      end

      invoices
    end
  end

end
