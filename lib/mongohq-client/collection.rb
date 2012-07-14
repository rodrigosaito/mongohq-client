module MongoHQClient
  class Collection
    include Commons
    include HTTP

    def documents
      json = get("databases/#{database}/collections/#{name}/documents")

      documents = []

      json.each do |doc|
        documents << Document.new(json:doc)
      end

      documents
    end

    def document(id)
      json = get("databases/#{database}/collections/#{name}/documents/#{id}")

      Document.new(json: json)
    end

    def indexes
      json = get("databases/#{database}/collections/#{name}/indexes")

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
