module Qiitan
	module API
		module Users
			# Mixin用のメソッドはselfで定義する必要はない？
			def get_user_info
				url = "#{API_BASE_URL}user?token=#{@token}"
				res = Qiitan::HTTP.request(url, :get, true)
				JSON.parse res.body
			end

			def get_users_info(url_name)
				url = "#{API_BASE_URL}users#{url_name}?token=#{@token}"
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
		end
	end
end
