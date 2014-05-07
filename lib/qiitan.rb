require "qiitan/version"
require 'net/http'
require 'uri'
require 'json'

module Qiitan
	API_BASE_URL = 'https://qiita.com/api/v1/'

	class Rest
		def initialize
		end

		def get(url, use_ssl = false, params = {})
			#URLパラメータを追加する
			if !params.empty? then
				url += '?'
				params.each do |k, v|
					url += k +'='+ v
				end
			end

			uri = URI.parse url
			req = Net::HTTP::Get.new uri.request_uri
			http = Net::HTTP.new uri.host, uri.port
			http.use_ssl = use_ssl
			res = http.request req

			#JSONをRubyのハッシュ形式にして返してあげる
			hashed = JSON.parse(res.body)
		end

		def post(url, use_ssl = false, form_data)
			uri = URI.parse url
			req = Net::HTTP::Post.new uri.request_uri
			req.set_form_data form_data
			http = Net::HTTP.new uri.host, uri.port
			http.use_ssl = use_ssl
			res = http.request req

			hashed = JSON.parse res.body
		end

		def put
		end

		def delete
		end
	end

	class Client
		def initialize(options)
			#uri = URI.parse 'https://qiita.com/api/v1/auth'
			#request = Net::HTTP::Post.new uri.request_uri
			#request.set_form_data(options)
			#http = Net::HTTP.new uri.host, uri.port
			#http.use_ssl = true
			##デバッグ時に使用する
			##http.set_debug_output STDERR
			#response = http.request(request)

			#@token = JSON.parse(response.body)['token']
			@rest = Qiitan::Rest.new
			hashed = @rest.post 'https://qiita.com/api/v1/auth', true, options
			@token = hashed['token']
		end

		def get_user_info
			#uri = URI.parse API_BASE_URL + 'user?token=' + @token
			#puts API_BASE_URL + 'user' + '/?token=' + @token
			#request = Net::HTTP::Get.new uri.request_uri
			#http = Net::HTTP.new uri.host, uri.port
			#http.use_ssl = true
			#response = http.request request
			#json = JSON.parse response.body
			@rest.get(API_BASE_URL + 'user', {'token' => @token })
		end
	end
end
