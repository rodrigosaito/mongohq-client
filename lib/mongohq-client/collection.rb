module MongoHQClient
  class Collection
    include Commons
    include HTTP

    def documents
      json = get("database/#{database}/collection/#{name}/documents")

      documents = []

      json.each do |doc|
        documents << Document.new(json:doc)
      end

      documents
    end

    def document(id)
      json = get("database/#{database}/collection/#{name}/documents/#{id}")

      Document.new(json: json)
    end

    def indexes
      json = get("database/#{database}/collection/#{name}/indexes")

      indexes = []

      json.each do |index|
        indexes << Index.new(json: index)
      end

      indexes
    end

    protected
    def database
      raise "Invalid database" unless @params[:database]
      @params[:database]
    end

  end
end
