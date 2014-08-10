get '/' do
	erb :index
end

get '/evaluate/:board_string' do
	params[:board_string] += "aaaaaaaaaaaaaaaa"
	@board_string = params[:board_string][0..15].downcase

	erb :result, layout: false
end

get '/api/evaluate/:board_string' do
	params[:board_string] += "aaaaaaaaaaaaaaaa"
	@board_string = params[:board_string][0..15].downcase
	erb :result_string, layout: false
end

