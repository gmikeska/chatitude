require 'sinatra'
require_relative 'lib/chatitude_db_repo.rb'
get '/' do
  erb :index
end


post '/signup' do
	user_data = {}
	user_data['username'] = params["username"]
	user_data['password'] = params["password"]
	user_data['apiToken'] = Chatitude.create_api_token(user_data)
	db = Chatitude.create_db_connection()
	Chatitude.add_user(db, user_data)
end

post '/signin' do
	user_data = {}
	user_data['username'] = params["username"]
	user_data['password'] = params["password"]
	db = Chatitude.create_db_connection()
	Chatitude.auth_user(db, user_data)
end

get  '/chats/:start_id' do
	last_id = params[:start_id]
	db = Chatitude.create_db_connection()
	Chatitude.get_chats(db, last_id)
end


post '/chats' do
	chat_data = {}
	chat_data['apiToken'] = params['apiToken']
	chat_data['message'] = params['message']
	db = Chatitude.create_db_connection()
	Chatitude.chat_received(db, chat_data)
end