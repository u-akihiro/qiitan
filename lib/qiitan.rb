require "qiitan/version"
require 'net/http'
require 'uri'
require 'json'

module Qiitan
	API_BASE_URL = 'https://qiita.com/api/v1/'

	class Rest
		def initialize
		end

		def get(url, use_ssl, params = {})
			##URLパラメータを追加する
			#if !params.empty? then
			#	url += '?'
			#	url += params.map do |k, v|
			#		"#{k}=#{CGI::escape(v.to_s)}"
			#	end.join('&')
			#end

			url = assemble_params url, params

			uri = URI.parse url
			req = Net::HTTP::Get.new uri.request_uri
			http = Net::HTTP.new uri.host, uri.port
			http.use_ssl = use_ssl
			res = http.request req

			#JSONをRubyのハッシュ形式にして返してあげる
			hashed = JSON.parse(res.body)
		end

		def post(url, use_ssl, form_data, params = {})
			url = assemble_params url, params if !params.empty? 

			uri = URI.parse url
			req = Net::HTTP::Post.new uri.request_uri
			#set_form_dataはバイナリファイルのアップロードは対応していないみたい
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

		private
			def assemble_params(url, params)
				#URLパラメータを追加する
				if !params.empty? then
					url += '?'
					url += params.map do |k, v|
						"#{k}=#{CGI::escape(v.to_s)}"
					end.join('&')
				end			
				url
			end
	end

	class Client
		def initialize(options)
			@rest = Qiitan::Rest.new
			hashed = @rest.post API_BASE_URL + 'auth', true, options
			raise 'auth error. check youre username and password' if hashed.key? 'error'
			@token = hashed['token']
		end

		def rate_limit
			url = API_BASE_URL + "rate_limit"
			hashed = @rest.get(url, true, {'token' => @token})
			hashed
		end

		def get_user_info
			url = API_BASE_URL + 'user'
			hashed = @rest.get(url, true, {'token' => @token })
		end

		def get_users_info(url_name)
			url = API_BASE_URL + 'users/' + url_name
			hashed = @rest.get(url, true, {'token' => @token})
		end

		def posted_by(url_name)
			url = API_BASE_URL + "users/#{url_name}/items"
			hashed = @rest.get(url, true, {'token' => @token})
		end

		def stocked_by(url_name)
			url = API_BASE_URL + "users/#{url_name}/stocks"
			hashed = @rest.get(url, true, {'token' => @token})
		end

		def post(item)
			item = JSON.generate(item)
			url = API_BASE_URL + "items/"
			hashed = @rest.post(url, true, item, {'token' => @token})
		end
	end
end
