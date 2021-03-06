require 'qiitan'

describe Qiitan do
	describe Qiitan::Client do
		describe "new" do
			context "トークンの取得に成功すると" do
				it 'clientインスタンスが生成される' do
					client = Qiitan::Client.new({url_name:'foo', password: 'atraptilandroin'})
					expect(client).to be_an_instance_of Qiitan::Client
				end
			end

			context "トークンの取得に失敗すると" do
				it '例外が投げられる' do
					expect do
						client = Qiitan::Client.new({url_name:'foo', password: ''})
					end.to raise_error(RuntimeError)
				end
			end
		end

		before do
			@client = Qiitan::Client.new({url_name:'foo', password: 'atraptilandroin'})
		end

		describe "#rate_limit" do
			context "正常に完了すると" do
				it "残りアクセス数がハッシュで返される" do
					expect(@client.rate_limit).to be_an_instance_of Hash
				end
			end
		end

		describe "#get_user_info" do
			context "正常に完了" do
				it "ログインしているユーザーの情報をハッシュで返す" do
					expect(@client.get_user_info).to be_an_instance_of  Hash
				end
			end
		end

		describe "#post" do
			context "正常に完了" do
				it "投稿結果がハッシュで返される" do
				item = {
						'title' => 'from qiitan',
						'tags' => [
							{'name' => 'test'}
						],
						'body' => 'this post from qiitan',
						'private' => true
					}.to_json
					expect(@client.post(item)).to be_an_instance_of Hash
				end
			end
		end

		describe "#tags_list" do
			context "正常に完了" do
				it "タグの一覧を配列で返す" do
					expect(@client.tags_list).to be_an_instance_of Array
				end
			end
		end

		describe "#get_newly_post" do
			context "正常に取得した場合" do
				it "最新の投稿を配列で返す" do
					expect(@client.get_newly_post).to be_an_instance_of Array
				end
			end
		end

		describe "#stocked" do
			context "正常に取得出来た場合" do
				it "ストックした投稿を配列で返す" do
					expect(@client.stocked).to be_an_instance_of Array
				end
			end
		end
	end
end
