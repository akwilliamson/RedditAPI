require 'net/http'
require 'JSON'

puts "******************"
puts "Welcome to Topper!"
puts "******************"
puts ""
puts "Please enter the subreddit you would like to retrieve posts from:"
puts ""
subreddit = gets.chomp
puts ""
puts "#{subreddit} eh? Nice choice!"
puts ""
puts "Enter the minimum number of upvotes a post should have to be worthy of your viewing:"
puts ""
number = gets.chomp.to_i
puts ""
puts "Great! Here are the posts in #{subreddit} with at least #{number} upvotes! (separated by asterisks)"
puts ""

url = URI.parse("http://www.reddit.com/r/#{subreddit}/top.json")
req = Net::HTTP::Get.new(url.to_s)
res = Net::HTTP.start(url.host, url.port) {|http|
  http.request(req)
}

output = JSON.parse(res.body)

output["data"]["children"].each do |x|
	if x["data"]["ups"] > number
		title = x["data"]["title"]
		upvotes = x["data"]["ups"]
		puts "*******************************"
		puts title
		puts "#{upvotes} upvotes"
	end
end