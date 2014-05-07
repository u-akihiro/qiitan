require 'net/https'
require 'uri'
require 'json'

uri = URI.parse 'https://qiita.com/api/v1/auth'
request = Net::HTTP::Post.new uri.request_uri
request.set_form_data({url_name: 'u-akihiro', password: 'trytersorandate'})
http = Net::HTTP.new uri.host, uri.port
http.use_ssl = true
#http.set_debug_output STDERR
response = http.request(request)

token = JSON.parse(response.body)['token']

puts token

#url = URI.parse('https://qiita.com/api/v1/auth')
#req = Net::HTTP::Post.new url.path
#req.set_form_data({username: 'u-akihiro', password: 'trytersorandate'})
#res = Net::HTTP.new(url.host, url.port).start do |http|
#	http.use_ssl = true
#	http.request req
#end
#
#p res
