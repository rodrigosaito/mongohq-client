require "spec_helper"

describe MongoHQClient::Collection do
  let(:subject) { MongoHQClient::Collection.new json: '{"name":"collection1","count":15,"storageSize":192512,"avgObjSize":2257.866666666667,"indexCount":1,"ok":1.0}', apikey: "123456" }

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

end
