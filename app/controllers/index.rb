get '/' do
	erb :index
end

get '/evaluate/:board_string' do
	@board_string = params[:board_string]
	erb :result
end

