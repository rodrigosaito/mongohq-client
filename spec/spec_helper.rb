$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'rspec'
require 'fakeweb'
require 'mongohq_client'

FakeWeb.allow_net_connect = false

shared_examples "attribute" do |attr, expected|
  it "should return #{attr} attribute" do
    subject.send(attr).should eq(expected)
  end
end

