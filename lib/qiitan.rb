require "qiitan/version"
require 'net/http'
require 'uri'
require 'json'

module Qiitan
	API_BASE_URL = 'https://qiita.com/api/v1/'

	module HTTP
		def self.request(url, http_method, use_ssl = false)
			uri = URI.parse url

			case http_method
			when :get then
				req = Net::HTTP::Get.new uri.request_uri
			when :post then
				req = Net::HTTP::Post.new uri.request_uri
			when :put then
				req = Net::HTTP::Put.new uri.request_uri
			when :delete then
				req = Net::HTTP::Delete.new uri.request_uri
			end

			yield req if block_given?

			http = Net::HTTP.new uri.host, uri.port
			#http.set_debug_output($stderr)
			http.use_ssl = use_ssl
			res = http.request req
		end
	end

	class Client
		attr_reader :token
		def initialize(account)
			url = "#{API_BASE_URL}auth"
			res = Qiitan::HTTP.request(url, :post, true) do |req|
				req.set_form_data account
			end

			hashed = JSON.parse res.body

			raise 'auth error. check youre username and password' if hashed.key? 'error'
			@token = hashed['token']
		end

		def rate_limit
			url = "#{API_BASE_URL}rate_limit?token=#{@token}"
			res = Qiitan::HTTP.request(url, :get, true)
			JSON.parse res.body
		end

		def get_user_info
			url = "#{API_BASE_URL}user?token=#{@token}"
			res = Qiitan::HTTP.request(url, :get, true)
			JSON.parse res.body
		end

		def get_users_info(url_name)
			url = "#{API_BASE_URL}users/#{url_name}?token=#{@token}"
			res = Qiitan::HTTP.request(url, :get, true)
			JSON.parse res.body
		end

		def posted_by(url_name)
			url = "#{API_BASE_URL}users/#{url_name}/items?token=#{@token}"
			res = Qiitan::HTTP.request(url, :get, true)
			JSON.parse res.body
		end

		def stocked_by(url_name)
			url = "#{API_BASE_URL}users/#{url_name}/items"
			res = Qiitan::HTTP.request(url, :get, true)
			JSON.parse res.body
		end

		def post(payload)
			url = "#{API_BASE_URL}items?token=#{@token}"
			res = Qiitan::HTTP.request(url, :post, true) do |req|
				req.content_type = "multipart/form-data"
				#Content-Typeが指定されていないとJSONを受け取ってくれない
				req['Content-Type'] = 'application/json'
				req.body = payload
			end

			JSON.parse res.body
		end

		def delete(uuid)
			url = "#{API_BASE_URL}items/#{uuid}?token=#{@token}"
			res = Qiitan::HTTP.request(url, :delete, true)
		end
	end
end
