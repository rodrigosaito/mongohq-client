require "spec_helper"

describe MongoHQClient::Database do

  let(:database) { MongoHQClient::Database.new json: JSON.parse('{"name":"database1","hostname":"host.mongohq.com","port":27036,"shared":true,"plan":"Micro"}'), apikey: "123456" }

  describe "#name" do
    it "should return the name of database" do
      database.name.should eq("database1")
    end
  end

  describe "#hostname" do
    it "should return hostname of database" do
      database.hostname.should eq("host.mongohq.com")
    end
  end

  describe "#port" do
    it "should return port of database" do
      database.port.should eq(27036)
    end
  end

  describe "#shared" do
    it "should return if database is shared" do
      database.shared?.should be_true
    end
  end

  describe "#plan" do
    it "should return the plan of database" do
      database.plan.should eq("Micro")
    end
  end

  it "should raise error where attribute is invalid" do
    expect {
      database.invalid
    }.to raise_error(NoMethodError)
  end

  describe "#details" do
    before do
      FakeWeb.register_uri :get, "https://api.mongohq.com/database/database1?_apikey=123456", body: '{"db":"database1","collections":10,"objects":1799,"avgObjSize":353.85881045025013,"dataSize":636592,"storageSize":2314240,"numExtents":17,"indexes":9,"indexSize":147168,"fileSize":251658240,"nsSizeMB":16,"ok":1.0,"name":"database1","hostname":"host.mongohq.com","port":27036,"shared":true,"plan":"Micro"}'
    end

    let(:details) { database.details }

    it "should return database details" do
      details.db.should eq("database1")
    end
  end

  describe "#collections" do
    before do
      FakeWeb.register_uri :get, "https://api.mongohq.com/database/database1/collections?_apikey=123456", body: '[{"name":"collections1","count":0,"storageSize":40960,"avgObjSize":null,"indexCount":1,"ok":1.0},{"name":"collection2","count":15,"storageSize":192512,"avgObjSize":2257.866666666667,"indexCount":1,"ok":1.0},{"name":"collections3","count":162,"storageSize":294912,"avgObjSize":1006.8395061728395,"indexCount":1,"ok":1.0},{"name":"collections4","count":36,"storageSize":8192,"avgObjSize":92.22222222222223,"indexCount":1,"ok":1.0},{"name":"collections5","count":0,"storageSize":8192,"avgObjSize":null,"indexCount":1,"ok":1.0},{"name":"collections6","count":0,"storageSize":8192,"avgObjSize":null,"indexCount":1,"ok":1.0},{"name":"collections7","count":1558,"storageSize":1740800,"avgObjSize":278.9165596919127,"indexCount":1,"ok":1.0}]'
    end

    let(:collections) { database.collections }

    it "should return collections" do
      collections.size.should eq(7)
    end
  end

  describe "#collection" do
    before do
      FakeWeb.register_uri :get, "https://api.mongohq.com/database/database1/collection/collection1?_apikey=123456", body: '{"ns":"database1.collection1","count":1558,"size":434552,"avgObjSize":278.9165596919127,"storageSize":1740800,"numExtents":4,"nindexes":1,"lastExtentSize":1310720,"paddingFactor":1.009999999999998,"flags":1,"totalIndexSize":81760,"indexSizes":{"_id_":81760},"ok":1.0}'
    end

    let(:collection) { database.collection "collection1" }

    it "should return collection with details" do
      collection.ns.should eq("database1.collection1")
    end
  end

end
