module Qiitan
	module API
		module Tags
			def tags_list
				url = "#{API_BASE_URL}tags?token=#{@token}"
				res = Qiitan::HTTP.request(url, :get, true)
				JSON.parse res.body
			end
		end
	end
end
