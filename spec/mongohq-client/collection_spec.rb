require "spec_helper"

describe MongoHQClient::Collection do
  let(:subject) { MongoHQClient::Collection.new json: JSON.parse('{"name":"collection1","count":15,"storageSize":192512,"avgObjSize":2257.866666666667,"indexCount":1,"ok":1.0}'), apikey: "123456", database: "database1" }

  describe "#name" do
    it_behaves_like "attribute", :name, "collection1"
  end

  describe "#count" do
    it_behaves_like "attribute", :count, 15
  end

  describe "#storageSize" do
    it_behaves_like "attribute", :storageSize, 192512
  end

  describe "#avgObjSize" do
    it_behaves_like "attribute", :avgObjSize, 2257.866666666667
  end

  describe "#indexCount" do
    it_behaves_like "attribute", :indexCount, 1
  end

  describe "#ok" do
    it_behaves_like "attribute", :ok, 1.0
  end

  describe "#documents" do
    before do
      FakeWeb.register_uri :get, "https://api.mongohq.com/databases/database1/collections/collection1/documents?_apikey=123456", body: '[{"_id":{"$oid": "4ffde13927bce841321005ec0"},"name":"Test User","updated_at":"2012-07-11 20:25:29 UTC","created_at":"2012-07-11 20:25:29 UTC"}]'
    end

    it "should return documents" do
      subject.documents.size.should eq(1)
    end
  end

  describe "#document" do
    before do
      FakeWeb.register_uri :get, "https://api.mongohq.com/databases/database1/collections/collection1/documents/4ffde13927bce841321005ec0?_apikey=123456", body: '{"_id":{"$oid": "4ffde13927bce841321005ec0"},"name":"Test User","updated_at":"2012-07-11 20:25:29 UTC","created_at":"2012-07-11 20:25:29 UTC"}'
    end

    it "should return document by id" do
      subject.document('4ffde13927bce841321005ec0').name.should eq("Test User")
    end
  end

  describe "#indexes" do
    before do
      FakeWeb.register_uri :get, "https://api.mongohq.com/databases/database1/collections/collection1/indexes?_apikey=123456", body: '[{"v":1,"key":{"_id":1},"ns":"database1.collection1","name":"_id_"}]'
    end

    it "should return indexes" do
      subject.indexes.size.should eq(1)
    end

    it "should return ns" do
      subject.indexes.first.ns.should eq("database1.collection1")
    end
  end

end
