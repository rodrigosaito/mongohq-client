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

    protected
    def database
      raise "Invalid database" unless @params[:database]
      @params[:database]
    end

  end
end
