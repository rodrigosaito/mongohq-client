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
    end

    let(:databases) { client.databases }

    it "should return 3 databases" do
      databases.size.should eq(3)
    end
  end

  describe "#invoices" do
    before do
      FakeWeb.register_uri :get, "https://api.mongohq.com/invoices?_apikey=#{client.apikey}", body: '[{"id":12345,"amount":5.0,"balance":0.0,"bill_date":"2012-07-01","is_paid":true}]'
    end

    let(:invoices) { client.invoices }

    it "should return 1 invoice" do
      invoices.size.should eq(1)
    end

    it "should return amount" do
      invoices.first.amount.should eq(5.0)
    end
  end

end
