require 'byebug'

class BoggleBoard
  def initialize
      @board = []
      @global_row_index = 0
      @global_col_index = 0
      @length = 0
  end

  def shake!
    temp_board =[]
    die = []
    @dice = [
            %w(A A E E G N),
            %w(A B B J O O),
            %w(A C H O P S),
            %w(A F F K P S),
            %w(A O O T T W),
            %w(C I M O T U),
            %w(D E I L R X),
            %w(D I S T T Y),
            %w(E E G H N W),
            %w(E E I N S U),
            %w(E H R T V W),
            %w(E I O S S T),
            %w(E L R T T Y),
            %w(H I M N U Q),
            %w(H L N N R Z),
            %w(D E I L R X)
          ]

    @dice.each { |x|

        letter = x.sample(1)[0]
        if letter == "Q"
          temp_board << "Qu".ljust(3)
        else
          temp_board << letter.ljust(2)
        end
    }    

    # @board = Array.new(4) {
    #  temp_board.shift(4).join
    # }

    @board = [
              %w(A W D E),
              %w(S B C F),
              %w(M O Z P),
              %w(N G K P)
          ]
  end

  def to_s
    if @board == []
      "----\n----\n----\n----"
    else
      "#{@board[0]}\n#{@board[1]}\n#{@board[2]}\n#{@board[3]}"
    end
  end

  def include?(word)
    #check word length
    @length = word.length
    final_word = ""
    is_word = false
    is_correct = false

    if @length < 3
      return false
    else
      letters = word.upcase.chars #Putting the letters into an array

      #Board Finding the value
      @board.each_with_index do |row_value, row_index|
        row_value.each_with_index do |col_value, col_index|

          @row_value = row_value

          #If First letter is in the bogle
          if is_word == false
            if col_value == letters[0]
              final_word = final_word + letters[0]
              letters.shift(1)
              is_word = true #found letter
            end
          end

          #Find next characters
          if is_word == true
            rw = row_index
            cl = col_index
            letters.each do |x|
              is_correct = check_next_letter(x,rw,cl)
              p is_correct
            end
          end
        end
      end
      return false
      #End Board Finding the value
    end
    return "Nothing happened"
  end

  def check_next_letter(letter,row_index,col_index)
      byebug
      if @board[row_index][col_index + 1] == letter
        #move to right 
         return true
      elsif @board[row_index][col_index - 1] == letter 
          #move to left
          return true
      elsif @board[row_index-1][col_index] == letter
          #move up
          return true
      elsif @board[row_index+1][col_index] == letter 
          #move down 
          return true 
      elsif @board[row_index+1][col_index+1] == letter  
          #move bottom right
          return true
      elsif @board[row_index-1][col_index+1] == letter
          #move top right
          return true
      elsif @board[row_index+1][col_index-1] == letter
          #move bottom left
          return true
      elsif @board[row_index-1][col_index-1] == letter 
          #move top left
          return true
      else
        return false
      end
  end
end

board = BoggleBoard.new
board.shake!
puts board
p board.include?(gets.chomp.to_s)




