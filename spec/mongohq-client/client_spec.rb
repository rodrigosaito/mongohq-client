require "spec_helper"

describe MongoHQClient::Client do
  let(:client) { MongoHQClient.from_apikey("123456") }

  describe "client creation" do

    it "should return a client with apikey" do
      client.apikey.should eq("123456")
    end
  end

  describe "#databases" do
    before do
      FakeWeb.register_uri :get, "https://api.mongohq.com/databases?_apikey=#{client.apikey}", body: '[{"name":"database1","hostname":"host.mongohq.com","port":27036,"shared":true,"plan":"Micro"},{"name":"database2","hostname":"host2.mongohq.com","port":10075,"shared":true,"plan":"Sandbox"},{"name":"database3","hostname":"staff.mongohq.com","port":10025,"shared":true,"plan":"Sandbox"}]'

      FakeWeb.register_uri :get, "https://api.mongohq.com/databases/database1?_apikey=#{client.apikey}", body: '{"db":"database1","collections":10,"objects":1799,"avgObjSize":353.85881045025013,"dataSize":636592,"storageSize":2314240,"numExtents":17,"indexes":9,"indexSize":147168,"fileSize":251658240,"nsSizeMB":16,"ok":1.0,"name":"database1","hostname":"host.mongohq.com","port":27036,"shared":true,"plan":"Micro"}'
    end

    let(:databases) { client.databases }

    it "should return 3 databases" do
      databases.size.should eq(3)
    end
  end

  describe "#databases by name" do
    let(:database) { client.databases("database1") }

    it "should return database by name" do
      database.name.should eq("database1")
    end
  end

  describe "#create_database" do
    before do
      FakeWeb.register_uri :post, "https://api.mongohq.com/databases?_apikey=#{client.apikey}", body: '{"ok":1}'
    end

    it "should create database" do
      client.create_database "my_new_db", "sandbox"
    end
  end

  describe "#invoices" do
    before do
      FakeWeb.register_uri :get, "https://api.mongohq.com/invoices?_apikey=#{client.apikey}", body: '[{"id":12345,"amount":5.0,"balance":0.0,"bill_date":"2012-06-01","is_paid":true},{"id":12346,"amount":5.0,"balance":0.0,"bill_date":"2012-07-01","is_paid":true}]'
    end

    let(:invoices) { client.invoices }

    it "should return 2 invoice" do
      invoices.size.should eq(2)
    end

    it "should return amount" do
      invoices.first.amount.should eq(5.0)
    end
  end

  describe "#invoice" do
    before do
      FakeWeb.register_uri :get, "https://api.mongohq.com/invoices/12345?_apikey=#{client.apikey}", body: '{"id":12345,"amount":5.0,"balance":0.0,"bill_date":"2012-06-01","is_paid":true}'
    end

    let(:invoice) { client.invoice("12345")}

    it "should return a paid invoice" do
      invoice.is_paid?.should be_true
    end
  end

  describe "#plans" do
    before do
      FakeWeb.register_uri :get, "https://api.mongohq.com/plans?_apikey=#{client.apikey}", body: '[{"name":"Micro","slug":"micro","price":5,"type":"hosted"},{"name":"Replica Set: Large","slug":"rs_large","price":300,"type":"hosted"}]'
    end

    let(:plans) { client.plans }

    it "should return plans" do
      plans.size.should eq(2)
    end
  end

end
