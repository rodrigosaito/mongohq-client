require "spec_helper"

describe MongoHQClient::DatabaseDetails do
  let(:subject) { MongoHQClient::DatabaseDetails.new json: '{"db":"database1","collections":10,"objects":1799,"avgObjSize":353.85881045025013,"dataSize":636592,"storageSize":2314240,"numExtents":17,"indexes":9,"indexSize":147168,"fileSize":251658240,"nsSizeMB":16,"ok":1.0,"name":"database1","hostname":"host.mongohq.com","port":27036,"shared":true,"plan":"Micro"}' }

  describe "#db" do
    it_behaves_like "attribute", :db, "database1"
  end

  describe "#collections" do
    it_behaves_like "attribute", :collections, 10
  end

  describe "#objects" do
    it_behaves_like "attribute", :objects, 1799
  end

  describe "#avgObjSize" do
    it_behaves_like "attribute", :avgObjSize, 353.85881045025013
  end

  describe "#dataSize" do
    it_behaves_like "attribute", :dataSize, 636592
  end

  describe "#storageSize" do
    it_behaves_like "attribute", :storageSize, 2314240
  end

  describe "#numExtents" do
    it_behaves_like "attribute", :numExtents, 17
  end

  describe "#indexes" do
    it_behaves_like "attribute", :indexes, 9
  end

  describe "#indexSize" do
    it_behaves_like "attribute", :indexSize, 147168
  end

  describe "#fileSize" do
    it_behaves_like "attribute", :fileSize, 251658240
  end

  describe "#nsSizeMB" do
    it_behaves_like "attribute", :nsSizeMB, 16
  end

  describe "#ok" do
    it_behaves_like "attribute", :ok, 1.0
  end

  describe "#name" do
    it_behaves_like "attribute", :name, "database1"
  end

  describe "#hostname" do
    it_behaves_like "attribute", :hostname, "host.mongohq.com"
  end

  describe "#port" do
    it_behaves_like "attribute", :port, 27036
  end

  describe "#shared" do
    it_behaves_like "attribute", :shared, true
  end

  describe "#plan" do
    it_behaves_like "attribute", :plan, "Micro"
  end

end
