class BoggleBoard
	attr_accessor :grid, :found_words, :r_index, :c_index, :score
	def initialize (string = "4")
		@found_words = []
		@covered_ground = []
		@score = 0
		build_board(string)
	end

	def build_board(string)
		if string.length == 16
			@grid = [
				[Die.new("aeegmu", 0, 0, string[0]) ,Die.new("aegmnn", 0, 1, string[1]) ,Die.new("afirsy", 0, 2, string[2]) ,Die.new("bjkqxz", 0, 3, string[3]) ],
				[Die.new("ceiilt", 1, 0, string[4]) ,Die.new("aaeeee", 1, 1, string[5]) ,Die.new("ceipst", 1, 2, string[6]) ,Die.new("adennn", 1, 3, string[7]) ],
				[Die.new("dhlnor", 2, 0, string[8]) ,Die.new("dhlnor", 2, 1, string[9]) ,Die.new("eiiitt", 2, 2, string[10]) ,Die.new("emottt", 2, 3, string[11]) ], 
				[Die.new("fiprsy", 3, 0, string[12]) ,Die.new("gorrvw", 3, 1, string[13]) ,Die.new("iprrry", 3, 2, string[14]) ,Die.new("nootuw", 3, 3, string[15]) ]
			]
		elsif string.length == 25
			@grid = [
				[Die.new("aeegmu", 0, 0, string[0]), Die.new("aegmnn", 0, 1, string[1]), Die.new("afirsy", 0, 2, string[2]), Die.new("bjkqxz", 0, 3, string[3]), Die.new("ccenst", 0, 4, string[4])], 
				[Die.new("ceiilt", 1, 0, string[5]), Die.new("aaeeee", 1, 1, string[6]), Die.new("ceipst", 1, 2, string[7]), Die.new("adennn", 1, 3, string[8]), Die.new("dhhlor", 1, 4, string[9])], 
				[Die.new("dhlnor", 2, 0, string[10]), Die.new("dhlnor", 2, 1, string[11]), Die.new("eiiitt", 2, 2, string[12]), Die.new("emottt", 2, 3, string[13]), Die.new("ensssu", 2, 4, string[14])], 
				[Die.new("fiprsy", 3, 0, string[15]), Die.new("gorrvw", 3, 1, string[16]), Die.new("iprrry", 3, 2, string[17]), Die.new("nootuw", 3, 3, string[18]), Die.new("ooottu", 3, 4, string[19])], 
				[Die.new("aaafrs", 4, 0, string[20]), Die.new("ceilpt", 4, 1, string[21]), Die.new("aafirs", 4, 2, string[22]), Die.new("ddhnot", 4, 3, string[23]), Die.new("aeeeem", 4, 4, string[24])]
			]
		elsif string == 5
			@grid = [
				[Die.new("aeegmu", 0, 0), Die.new("aegmnn", 0, 1), Die.new("afirsy", 0, 2), Die.new("bjkqxz", 0, 3), Die.new("ccenst", 0, 4)], 
				[Die.new("ceiilt", 1, 0), Die.new("aaeeee", 1, 1), Die.new("ceipst", 1, 2), Die.new("adennn", 1, 3), Die.new("dhhlor", 1, 4)], 
				[Die.new("dhlnor", 2, 0), Die.new("dhlnor", 2, 1), Die.new("eiiitt", 2, 2), Die.new("emottt", 2, 3), Die.new("ensssu", 2, 4)], 
				[Die.new("fiprsy", 3, 0), Die.new("gorrvw", 3, 1), Die.new("iprrry", 3, 2), Die.new("nootuw", 3, 3), Die.new("ooottu", 3, 4)], 
				[Die.new("aaafrs", 4, 0), Die.new("ceilpt", 4, 1), Die.new("aafirs", 4, 2), Die.new("ddhnot", 4, 3), Die.new("aeeeem", 4, 4)]
			]
		else
			@grid = [
				[Die.new("aeegmu", 0, 0) ,Die.new("aegmnn", 0, 1) ,Die.new("afirsy", 0, 2) ,Die.new("bjkqxz", 0, 3) ], 
				[Die.new("ceiilt", 1, 0) ,Die.new("aaeeee", 1, 1) ,Die.new("ceipst", 1, 2) ,Die.new("adennn", 1, 3) ], 
				[Die.new("dhlnor", 2, 0) ,Die.new("dhlnor", 2, 1) ,Die.new("eiiitt", 2, 2) ,Die.new("emottt", 2, 3) ], 
				[Die.new("fiprsy", 3, 0) ,Die.new("gorrvw", 3, 1) ,Die.new("iprrry", 3, 2) ,Die.new("nootuw", 3, 3) ]  
			]
		end
	end

	def take_turn
		roll
		evaluate_board
	end

	def total_score
		@score = @found_words.uniq.inject(0) do |sum, word| 
			case 
			when word.length == 3 || word.length == 4
				points =  1
			when word.length == 5
				points =  2
			when word.length == 6
				points =  3
			when word.length == 7
				points =  5
			when word.length > 7
				points =  11
			else
				points = 0
			end
			points + sum
		end
		@score
	end

	def to_s
		output_string = ""
		@grid.each do |row|
			row.each do |die|
				output_string << die.top
			end
			output_string << "\n"
		end
		output_string
	end

	def to_html
		output_string = ""
		@grid.each do |row|
			row.each do |die|
				output_string << die.top
			end
			output_string << "</br>"
		end
		output_string
	end

	def to_flat_s
		output_string = ""
		@grid.each do |row|
			row.each do |die|
				output_string << die.top
			end
		end
		output_string
	end

	def roll
		@grid.shuffle!
		@grid.each_with_index do |row, r_index| 
			row.shuffle!
			row.each_with_index do |die, c_index| 
				die.roll(r_index, c_index)
			end
		end
	end

	def loop_board
		@grid.each do |row|
			row.each do |die|
				yield die
			end	
		end
	end

	def evaluate_board
		loop_board do |die|
			@c_index = die.c_index
			@r_index = die.r_index
			@score = 0
			@current_word = die.top
			@covered_ground = ["#{@r_index}#{@c_index}"]
			find_words
		end
		total_score
		@found_words.sort!.uniq!
	end


	def find_words #recursive
		return nil if !binary_is_word_path? || ($end_time && Time.now > $end_time)
		@found_words << @current_word if binary_is_valid_word? && !@found_words.include?(@current_word)
		
		#Traverse in each direction, and recurse
		n
		ne
		e
		se
		s
		sw
		w
		nw
	end

	#Uses database of Terms
	# def is_valid_word?
	# 	if Term.where(word: "#{@current_word}").length != 0 && @current_word.length > 2
	# 		puts "WORD: #{@current_word}" 
	# 		return true
	# 	end
	# 	false
	# end
	# def is_word_path?
	# 	Term.where("word LIKE (?)", "#{@current_word}%").length != 0
	# end


	#database free version
	def binary_is_valid_word?
		return false if @current_word.length < 3
		@current_word.downcase
		low_i = 0
		i = $terms.length / 2
		high_i = $terms.length - 1
		while low_i <= high_i
			i = (high_i + low_i)/2
			if $terms[i].downcase == @current_word
				# puts "i:#{i},   low_i:#{low_i}, high_i:#{high_i}, #{$terms[i]}"
				return true
			elsif @current_word < $terms[i].downcase
				high_i = i - 1
			elsif @current_word > $terms[i].downcase
				low_i = i + 1
			end
		end
		return false
	end

	def binary_is_word_path?
		@current_word.downcase
		low_i = 0
		i = $terms.length / 2
		high_i = $terms.length - 1
		while low_i <= high_i
			i = (high_i + low_i)/2
			if $terms[i][0..@current_word.length - 1].downcase == @current_word
				# puts "i:#{i},   low_i:#{low_i}, high_i:#{high_i}, #{$terms[i][0..@current_word.length - 1]}"
				return true
			elsif @current_word < $terms[i].downcase
				high_i = i - 1
			elsif @current_word > $terms[i].downcase
				low_i = i + 1
			end
		end
		# puts "i:#{i},   low_i:#{low_i}, high_i:#{high_i}, #{$terms[i][0..@current_word.length - 1]}"
		return false
	end




	def n
		return nil if @r_index == 0 || @covered_ground.include?("#{@r_index - 1}#{@c_index}")
		@r_index -= 1
		@covered_ground << "#{@r_index}#{@c_index}"
		@current_word += "#{@grid[@r_index][@c_index].top}"
		find_words
		@r_index += 1
		@covered_ground.pop
		@current_word = @current_word[0...-1]

	end


	def ne
		return nil if @r_index == 0 || @c_index + 1 >= @grid.length|| @covered_ground.include?("#{@r_index - 1}#{@c_index + 1}")
		@r_index -= 1
		@c_index += 1
		@covered_ground << "#{@r_index}#{@c_index}"
		@current_word += "#{@grid[@r_index][@c_index].top}"
		find_words
		@r_index += 1
		@c_index -= 1
		@covered_ground.pop
		@current_word = @current_word[0...-1]

	end



	def e
		return nil if @c_index + 1 >= @grid.length || @covered_ground.include?("#{@r_index}#{@c_index + 1}")
		@c_index += 1
		@covered_ground << "#{@r_index}#{@c_index}"
		@current_word += "#{@grid[@r_index][@c_index].top}"
		find_words
		@c_index -= 1
		@covered_ground.pop
		@current_word = @current_word[0...-1]
	end

	def se
		return nil if @r_index + 1 >= @grid.length || @c_index + 1 >= @grid.length || @covered_ground.include?("#{@r_index + 1}#{@c_index + 1}")
		@r_index += 1
		@c_index += 1
		@covered_ground << "#{@r_index}#{@c_index}"
		@current_word += "#{@grid[@r_index][@c_index].top}"
		find_words
		@r_index -= 1
		@c_index -= 1
		@covered_ground.pop
		@current_word = @current_word[0...-1]	

	end

	def s
		return nil if @r_index + 1 >= @grid.length || @covered_ground.include?("#{@r_index + 1}#{@c_index}")
		@r_index += 1
		@covered_ground << "#{@r_index}#{@c_index}"
		@current_word += "#{@grid[@r_index][@c_index].top}"
		find_words
		@r_index -= 1
		@covered_ground.pop
		@current_word = @current_word[0...-1]	
	end

	def sw
		return nil if @r_index + 1 >= @grid.length || @c_index == 0 || @covered_ground.include?("#{@r_index + 1}#{@c_index - 1}")
		@r_index += 1
		@c_index -= 1
		@covered_ground << "#{@r_index}#{@c_index}"
		@current_word += "#{@grid[@r_index][@c_index].top}"
		find_words
		@r_index -= 1
		@c_index += 1
		@covered_ground.pop
		@current_word = @current_word[0...-1]
	end

	def w
		return nil if @c_index == 0 || @covered_ground.include?("#{@r_index}#{@c_index - 1}")
		@c_index -= 1
		@covered_ground << "#{@r_index}#{@c_index}"
		@current_word += "#{@grid[@r_index][@c_index].top}"
		find_words
		@c_index += 1
		@covered_ground.pop
		@current_word = @current_word[0...-1]		
	end

	def nw
		return nil if @c_index == 0 || @r_index == 0 || @covered_ground.include?("#{@r_index - 1}#{@c_index - 1}")
		@r_index -= 1
		@c_index -= 1
		@covered_ground << "#{@r_index}#{@c_index}"
		@current_word += "#{@grid[@r_index][@c_index].top}"
		find_words
		@r_index += 1
		@c_index += 1
		@covered_ground.pop
		@current_word = @current_word[0...-1]	
	end




end

class Die
	attr_accessor :top, :r_index, :c_index
	def initialize (sides, r_index, c_index, top = nil)
		@sides = sides.chars
		@top = top ? top : @sides[0]
		set_position(r_index, c_index)
	end

	def roll(r_index, c_index)
		@top = @sides.sample
        set_position(r_index, c_index)
	end

	def set_position(r_index, c_index)
		@r_index = r_index
		@c_index = c_index
		self
	end

end