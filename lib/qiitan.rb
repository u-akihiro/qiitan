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
			@rest = Qiitan::Rest.new
			hashed = @rest.post 'https://qiita.com/api/v1/auth', true, options
			@token = hashed['token']
		end

		def get_user_info
			url = API_BASE_URL + 'user'
			hashed = @rest.get(url, true, {'token' => @token })
		end

		def get_users_info(url_name)
			url = API_BASE_URL + 'users/' + url_name
			hashed = @rest.get(url, true, {'token' => @token})
		end
	end
end
