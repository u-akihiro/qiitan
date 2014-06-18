module Qiitan
	module API
		module Users
=begin
ログインしているユーザーの情報をHashにて返す
=end
			def get_user_info
				url = "#{API_BASE_URL}user?token=#{@token}"
				res = Qiitan::HTTP.request(url, :get, true)
				JSON.parse res.body
			end
=begin
取得したいユーザー名を指定します
=end
			def get_users_info(url_name)
				url = "#{API_BASE_URL}users#{url_name}?token=#{@token}"
				res = Qiitan::HTTP.request(url, :get, true)
				JSON.parse res.body
			end
=begin
ユーザー名を指定することで、その人が投稿した記事を取得することが出来ます
=end
			def posted_by(url_name)
				url = "#{API_BASE_URL}users/#{url_name}/items?token=#{@token}"
				res = Qiitan::HTTP.request(url, :get, true)
				JSON.parse res.body
			end

=begin
ユーザー名を指定することで、その人がストックした記事の一覧を取得することが出来ます
=end
			def stocked_by(url_name)
				url = "#{API_BASE_URL}users/#{url_name}/items"
				res = Qiitan::HTTP.request(url, :get, true)
				JSON.parse res.body
			end

=begin
自身がストックした記事の一覧を取得出来ます
=end
			def stocked
				url = "#{API_BASE_URL}stocks?token=#{@token}"
				res = Qiitan::HTTP.request(url, :get, true)
				JSON.parse res.body
			end
		end
	end
end
