module Qiitan
	module API
		module Items
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
		end
	end
end
