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

    protected
    def database
      raise "Invalid database" unless @params[:database]
      @params[:database]
    end

  end
end
