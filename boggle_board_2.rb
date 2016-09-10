require 'byebug'

class BoggleBoard
  def initialize
      @board = []
  end

  def shake!
    temp_board =[]
    dice =     [ %w(A A E E G N),
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
                  %w(D E I L R X) ]

    dice.each { |x|
      letter = x.sample(1)[0]
      if letter == "Q"
        temp_board << "Qu"
      else
        temp_board << letter
      end
    }    

     @board = Array.new(4) {
      temp_board.shift(4)
     }

     # @board = [%w(A W D E),
     #           %w(S B C F),
     #           %w(M O Z P),
     #           %w(N G K P)]
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
    length = word.length
    final_word = ""
    is_word = false
    is_correct = false

    if length < 3
      return false
    else
      letters = word.upcase.chars #Putting the letters into an array

      #Board Finding the value
      @board.each_with_index do |row_value, row_index|
        row_value.each_with_index do |col_value, col_index|

          #If first letter is in the boogle
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
                  return false #word doesnt exist
                else
                  #returning coordinates
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
      if row_index + 1 == 4 && col_index + 1 == 4  #if you are in the bottom right corner 3,3
        move_up(letter,row_index,col_index)
        move_left(letter,row_index,col_index)
        move_top_left(letter,row_index,col_index)

      elsif row_index + 1 == 4 && col_index == 0 #if you are in the bottom left corner 3,0
        move_up(letter,row_index,col_index)
        move_right(letter,row_index,col_index)
        move_top_right(letter,row_index,col_index)

      elsif row_index == 0 && col_index + 1 == 4 #if you are in the top right corner 0,3
        move_down(letter,row_index,col_index)
        move_left(letter,row_index,col_index)
        move_bottom_left(letter,row_index,col_index)

      elsif row_index == 0 && col_index == 0 #if you are in the top left corner 0,0
        move_right(letter,row_index,col_index)
        move_down(letter,row_index,col_index)
        move_bottom_right(letter,row_index,col_index)

       elsif row_index == 0 && col_index + 1 > 0 && col_index + 1 < 3 #if you are in the top 0,1 0,2
        move_left(letter,row_index,col_index)
        move_right(letter,row_index,col_index)
        move_down(letter,row_index,col_index)
        move_bottom_right(letter,row_index,col_index)
        move_bottom_left(letter,row_index,col_index)

      elsif row_index == 3 && col_index + 1 > 0 && col_index + 1 < 3 #if you are in the bottom 3,1 3,2
        move_left(letter,row_index,col_index)
        move_right(letter,row_index,col_index)
        move_up(letter,row_index,col_index)
        move_top_right(letter,row_index,col_index)
        move_top_left(letter,row_index,col_index)

      elsif col_index == 0 && row_index + 1 > 0 && row_index + 1 < 3 #if you are in the left 0,1 0,2
        move_right(letter,row_index,col_index)
        move_up(letter,row_index,col_index)
        move_down(letter,row_index,col_index)
        move_top_right(letter,row_index,col_index)
        move_bottom_right(letter,row_index,col_index)

      elsif col_index == 3 && row_index + 1 > 0 && row_index + 1 < 3 #if you are in the right 3,1 3,2
        move_left(letter,row_index,col_index)
        move_down(letter,row_index,col_index)
        move_up(letter,row_index,col_index)
        move_top_left(letter,row_index,col_index)
        move_top_right(letter,row_index,col_index)

      elsif col_index + 1 > 0 && col_index + 1 < 3 && row_index + 1 > 0 && row_index + 1 < 3 #if you are in between 1,1 1,2 2,1 2,2


        if move_left(letter,row_index,col_index) != [row_index,row_column]
          return position
        elsif move_down(letter,row_index,col_index) != [row_index,row_column]
          position = move_down(letter,row_index,col_index)
          return position
        else
          move_up(letter,row_index,col_index)
          move_right(letter,row_index,col_index)
          move_top_left(letter,row_index,col_index)
          move_top_right(letter,row_index,col_index)
          move_bottom_right(letter,row_index,col_index)
          move_bottom_left(letter,row_index,col_index)
        end
      else
        return false #if nothing works
      end
      return [row_index,col_index]  
  end 

  def move_up(letter,row_index,col_index)
     #byebug
      if @board[row_index-1][col_index] == letter
        row_index = row_index - 1
        return [row_index,col_index]
      end
  end

  def move_down(letter,row_index,col_index)
    #byebug
      if @board[row_index+1][col_index] == letter
        row_index = row_index + 1
        return [row_index,col_index]
      end
  end

  def move_left(letter,row_index,col_index)
      if @board[row_index][col_index - 1] == letter
        col_index = col_index - 1
        return [row_index,col_index]
      end
  end

  def move_right(letter,row_index,col_index)
      if @board[row_index][col_index + 1] == letter
        col_index = col_index + 1
        return [row_index,col_index]
      end
  end

  def move_top_right(letter,row_index,col_index)
      if @board[row_index-1][col_index+1] == letter 
        #move top right
        row_index = row_index - 1
        col_index = col_index + 1
        return [row_index,col_index]
      end
  end

  def move_top_left(letter,row_index,col_index)
      if @board[row_index+1][col_index+1] == letter 
        #move bottom right
        row_index = row_index + 1
        col_index = col_index + 1
        return [row_index,col_index]
      end
  end

  def move_bottom_left(letter,row_index,col_index)
      if @board[row_index+1][col_index-1] == letter   
        #move bottom left
        row_index = row_index + 1
        col_index = col_index - 1
        return [row_index,col_index]
      end
  end

  def move_bottom_right(letter,row_index,col_index)
      if @board[row_index-1][col_index-1] == letter  
        #move top left
        row_index = row_index - 1
        col_index = col_index - 1
        return [row_index,col_index]
      end
  end

  

 
end

board = BoggleBoard.new
board.shake!
puts board
p board.include?(gets.chomp.to_s)




