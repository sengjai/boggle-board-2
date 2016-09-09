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
          temp_board << "Q"
        else
          temp_board << letter
        end
    }    

      @board = Array.new(4) {
       temp_board.shift(4)
      }

     # @board = [
     #           %w(A W D E),
     #           %w(S B C F),
     #           %w(M O Z P),
     #           %w(N G K P)
     #       ]
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
              if final_word.length == word.length
                if final_word == word.upcase                
                   return final_word
                end
              else
                is_correct = check_next_letter(x,rw,cl)
                if is_correct == false
                  return false
                else
                  #returning coordinates
                  #byebug
                    final_word = final_word + x
                    rw = is_correct[0]
                    cl = is_correct[1]
                end
              end
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
      #byebug

      if @board[row_index][col_index + 1] == letter
        #move to right 
        col_index = col_index + 1
        return [row_index,col_index]

      elsif @board[row_index][col_index - 1] == letter
          #move to left
          col_index = col_index - 1
          return [row_index,col_index]

      elsif @board[row_index-1][col_index] == letter
          #move up
          row_index = row_index - 1
          return [row_index,col_index]

      elsif @board[row_index+1][col_index] == letter
          #move down 
          row_index = row_index + 1
          return [row_index,col_index]

      elsif @board[row_index+1][col_index+1] == letter 
          #move bottom right
          row_index = row_index + 1
          col_index = col_index + 1
          return [row_index,col_index]

      elsif @board[row_index-1][col_index+1] == letter 
          #move top right
          row_index = row_index - 1
          col_index = col_index + 1
          return [row_index,col_index]

      elsif @board[row_index+1][col_index-1] == letter   
          #move bottom left
          row_index = row_index + 1
          col_index = col_index - 1
          return [row_index,col_index]

      elsif @board[row_index-1][col_index-1] == letter  
          #move top left
          row_index = row_index - 1
          col_index = col_index - 1
          return [row_index,col_index]
      else
        return false
      end
  end
end

board = BoggleBoard.new
board.shake!
puts board
p board.include?(gets.chomp.to_s)




