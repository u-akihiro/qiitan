module Qiitan
	module API
		module Tags
=begin
Qiitaにて使用されているタグを取得する
=end
			def tags_list
				url = "#{API_BASE_URL}tags?token=#{@token}"
				res = Qiitan::HTTP.request(url, :get, true)
				JSON.parse res.body
			end
		end
	end
end
