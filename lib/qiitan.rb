require "qiitan/version"
require 'net/http'
require 'uri'
require 'json'
require 'qiitan/api/users'
require 'qiitan/api/items'
require 'qiitan/api/tags'

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

	#ToDo 増えすぎたメソッドはModuleで分割する予定
	class Client
		include Qiitan::API::Users
		include Qiitan::API::Items
		include Qiitan::API::Tags
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
	end
end
