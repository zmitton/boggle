get '/' do
	erb :index
end

get '/evaluate/:board_string' do
	if params[:board_string].length != 16 
		params[:board_string] += "aaaaaaaaaaaaaaaa"
		params[:board_string] = params[:board_string][0..15].downcase
	end

	@board_string = params[:board_string]
	erb :result, layout: false
end

get '/api/evaluate/:board_string' do
	if params[:board_string].length != 16 
		params[:board_string] += "aaaaaaaaaaaaaaaa"
		params[:board_string] = params[:board_string][0..15].downcase
	end

	@board_string = params[:board_string]
	erb :result_string, layout: false
end

