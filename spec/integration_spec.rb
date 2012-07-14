require "spec_helper"

describe "Integration Tests" do
  let(:client) { MongoHQClient.from_apikey "123456" }

  before do
    FakeWeb.register_uri :get, "https://api.mongohq.com/databases?_apikey=#{client.apikey}", body: '[{"name":"database1","hostname":"host.mongohq.com","port":27036,"shared":true,"plan":"Micro"},{"name":"database2","hostname":"host2.mongohq.com","port":10075,"shared":true,"plan":"Sandbox"},{"name":"database3","hostname":"staff.mongohq.com","port":10025,"shared":true,"plan":"Sandbox"}]'

    FakeWeb.register_uri :get, "https://api.mongohq.com/databases/database1/collections?_apikey=123456", body: '[{"name":"collections1","count":0,"storageSize":40960,"avgObjSize":null,"indexCount":1,"ok":1.0},{"name":"collection2","count":15,"storageSize":192512,"avgObjSize":2257.866666666667,"indexCount":1,"ok":1.0},{"name":"collections3","count":162,"storageSize":294912,"avgObjSize":1006.8395061728395,"indexCount":1,"ok":1.0},{"name":"collections4","count":36,"storageSize":8192,"avgObjSize":92.22222222222223,"indexCount":1,"ok":1.0},{"name":"collections5","count":0,"storageSize":8192,"avgObjSize":null,"indexCount":1,"ok":1.0},{"name":"collections6","count":0,"storageSize":8192,"avgObjSize":null,"indexCount":1,"ok":1.0},{"name":"collections7","count":1558,"storageSize":1740800,"avgObjSize":278.9165596919127,"indexCount":1,"ok":1.0}]'

    FakeWeb.register_uri :get, "https://api.mongohq.com/databases/database1/collections/collections1/documents?_apikey=123456", body: '[{"_id":{"$oid": "4ffde13927bce841321005ec0"},"name":"Test User","updated_at":"2012-07-11 20:25:29 UTC","created_at":"2012-07-11 20:25:29 UTC"}]'

    FakeWeb.register_uri :get, "https://api.mongohq.com/databases/database1/collections/collections1/indexes?_apikey=123456", body: '[{"v":1,"key":{"_id":1},"ns":"database1.collection1","name":"_id_"}]'
  end

  describe "#databases" do
    let(:databases) { client.databases }

    it "should return databases" do
      databases.size.should eq(3)
    end

    describe "#collections" do
      let(:collections) { databases.first.collections }

      it "should return collections" do
        collections.size.should eq(7)
      end

      describe "#documents" do
        let(:documents) { collections.first.documents }

        it "should return documents" do
          documents.size.should eq(1)
        end
      end

      describe "#indexes" do
        let(:indexes) { collections.first.indexes}

        it "should return indexes" do
          indexes.size.should eq(1)
        end
      end
    end
  end

end
