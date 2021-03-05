require 'twitter_client'

def load_mentions
  mentions = File.readlines('/Users/shinyarie/documents/work/twitter_bot/mentionlist.txt')
  mentions.map! {|e| e.chomp }
  return mentions
end

def save_mentions(mentions)
  File.open('/Users/shinyarie/documents/work/twitter_bot/mentionlist.txt', 'w') {|f|
    mentions.each do |e|
      f.write "#{e}\n"
    end
  }
end

client = twitter_client
mentions = load_mentions

client.mentions_timeline.each do |tweet|
  if mentions.select{ |e| e == tweet.id.to_s }.size == 0
    client.update("@#{tweet.user.screen_name}\nうざ", options = {:in_reply_to_status_id => tweet.id})
    mentions.push tweet.id
    save_mentions(mentions)
    client.favorite(tweet.id)
  end
end
