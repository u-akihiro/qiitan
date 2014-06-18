module Qiitan
	module API
		module Items
=begin
==== Args
Hash
=end
			def post(payload)
				url = "#{API_BASE_URL}items?token=#{@token}"
				res = Qiitan::HTTP.request(url, :post, true) do |req|
					req['Content-Type'] = 'application/json'
					req.body = payload
				end

				JSON.parse res.body
			end

			def delete
				url = "#{API_BASE_URL}items/#{uuid}?token=#{@token}"
				res = Qiitan::HTTP.request(url, :delete, true)
			end

			def get_newly_post
				url = "#{API_BASE_URL}items?token=#{@token}"
				res = Qiitan::HTTP.request(url, :get, true)

				JSON.parse res.body
			end
		end
	end
end
