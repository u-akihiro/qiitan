require 'qiitan'

describe Qiitan do
	describe Qiitan::Client do
		describe '#initialize' do
			context 'トークンの取得に成功した場合' do
				it 'Qiitan::Clientのインスタンスを取得する' do
					expect(Qiitan::Client.new({url_name: 'u-akihiro', password: 'trytersorandate'})).to be_an_instance_of Qiitan::Client
				end
			end
		end

		describe '#get_user_info' do
			context 'ログインしているユーザーの情報を返す' do
				it '結果をハッシュで返す' do
					@qiitan_client = Qiitan::Client.new({url_name: 'u-akihiro', password: 'trytersorandate'})
					expect(@qiitan_client.get_user_info).to be_an_instance_of Hash
				end
			end
		end
	end
end
