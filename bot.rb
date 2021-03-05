require 'twitter_client'

def load_mentions
  mentions = File.readlines('/Users/shinyarie/documents/work/ruby_bot/mentionlist.txt')
  mentions.map! {|e| e.chomp }
  return mentions
end

#def load_count
  #count = File.readlines('count.txt')
  #return count[0].to_i
#end

# 引数にmentions(配列)を受け取ってファイル（itemlist .text)に出力する
def save_mentions(mentions)
  File.open('/Users/shinyarie/documents/work/ruby_bot/mentionlist.txt', 'w') {|f|
    mentions.each do |e|
      f.write "#{e}\n"
    end
  }
end

#def save_count(count)
  #File.open('count.txt', 'w') { |f| f.write count }
#end

client = twitter_client
mentions = load_mentions
#count = load_count

client.mentions_timeline.each do |tweet|
  if mentions.select{ |e| e == tweet.id.to_s }.size == 0
    #count += 1
    #puts "hoge ID:#{count}"
    client.update("@#{tweet.user.screen_name}\nうざ", options = {:in_reply_to_status_id => tweet.id})
    mentions.push tweet.id
    save_mentions(mentions)
    #save_count(count)
  end
end
