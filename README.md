# Mongohq::Client

A simple MongoHQ api client for ruby

## Installation

Add this line to your application's Gemfile:

    gem 'mongohq-client'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mongohq-client

## Usage

Require mongohq-client

    require 'mongohq-client'

Authenticate with you apikey

    client = MongoHQClient.from_apikey("youapikey")

Retrieve all your databases

    databases = client.databases

Retrive collections from database

    collections = client.databases.first.collections

Retrieve documents from collection

    documents = client.databases.first.collections.first.documents

Retrieve indexes from from collection

    indexes = client.databases.first.collections.first.indexes

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
