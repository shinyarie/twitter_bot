require 'twitter'

def datadir
  '__TODO_DATA_DIR__'
end

def twitter_client
  Twitter::REST::Client.new do |config|
    config.consumer_key    = "__TODO__"
    config.consumer_secret = "__TODO__"
    config.access_token    = "__TODO__"
    config.access_token_secret = "__TODO__"
  end
end
