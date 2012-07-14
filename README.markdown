# MongoHQ Client

Simple ruby client for MongoHQ API.

## Using

  # Authenticate with your api key
  client = MongoHQClient.from_apikey("1234567890")

  # Get all databases
  databases = client.databases

  # Get a specific database
  database = client.database("database1")

  # Get collections for specific database
  collections = database.collections
