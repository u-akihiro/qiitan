require 'qiitan'

describe Qiitan do
	#describe Qiitan::Rest do
	#	before do
	#		@rest = Qiitan::Rest.new
	#	end

	#	describe '#get' do
	#		context 'URLを指定されたとき' do
	#			it '指定されたURLにGETリクエストを投げる' do
	#				expect(@rest).to eq 
	#			end
	#		end
	#	end

	#	describe '#post' do
	#		context 'URLとform dataを指定されたとき' do
	#			it '指定されたURLにPOSTリクエストを投げる' do
	#				
	#			end
	#		end
	#	end
	#end

	describe Qiitan::Client do
		describe '#initialize' do
			context 'トークンの取得に成功した場合' do
				it 'Qiitan::Clientのインスタンスを取得する' do
					expect(Qiitan::Client.new({url_name: 'u-akihiro', password: 'zeekerogycdrtb'})).to be_an_instance_of Qiitan::Client
				end
			end

			context '認証に失敗した場合' do
				it '例外が放出される' do
					expect do
						@qiia = Qiitan::Client.new(url_name: 'u-akihiro', password: '')
					end.to raise_error(RuntimeError)
				end
			end
		end

		describe '#get_user_info' do
			context 'ログインしているユーザーの情報を返す' do
				it '結果をハッシュで返す' do
					@qiitan_client = Qiitan::Client.new({url_name: 'u-akihiro', password: 'zeekerogycdrtb'})
					expect(@qiitan_client.get_user_info).to be_an_instance_of Hash
				end
			end
		end

		describe '#get_users_info' do
			context 'ユーザー名を指定すると' do
				it 'ユーザー情報をハッシュで返す' do
					@qiitan_client = Qiitan::Client.new({url_name: 'u-akihiro', password: 'zeekerogycdrtb'})
					expect(@qiitan_client.get_users_info('u-akihiro')).to be_an_instance_of Hash
				end
			end
		end

		describe '#posted_by' do
			context '特定のユーザー名を指定すると' do
				it '指定したユーザーの投稿を取得出来る' do
					@qiitan_client = Qiitan::Client.new({url_name: 'u-akihiro', password: 'zeekerogycdrtb'})
					expect(@qiitan_client.posted_by('luckypool')).to be_an_instance_of Array
				end
			end
		end

		describe '#stocked_by' do
			context '特定のユーザーを指定すると' do
				it '指定したユーザーがストックした投稿を取得出来る' do
					@qiitan_client = Qiitan::Client.new({url_name: 'u-akihiro', password: 'zeekerogycdrtb'})
					expect(@qiitan_client.stocked_by('u-akihiro')).to be_instance_of Array
				end
			end
		end

		describe '#rate_limit' do
			context 'tokenを指定してrate_limitを実行すると' do
				it 'APIのリミットをハッシュで取得出来る' do
					@qiitan_client = Qiitan::Client.new({url_name: 'u-akihiro', password: 'zeekerogycdrtb'})
					expect(@qiitan_client.rate_limit).to be_instance_of Hash
				end
			end
		end

		describe '#post' do
			context '指定した構造のハッシュを与えると' do
				it 'Qiitaに記事をポストする' do
					item = {
						title: 'posted by Qiitan',
						tags: [
							{name: 'hello'},
							{name: 'world'}
						],
						body: 'posted by Qiitan. Hahaha.',
						private: false,
					}
					@qiitan_client = Qiitan::Client.new({url_name: 'u-akihiro', password: 'zeekerogycdrtb'})
					expect(@qiitan_client.post(item)).to be_instance_of Hash
				end
			end
		end
	end
end
