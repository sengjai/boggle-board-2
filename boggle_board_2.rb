require 'byebug'

class BoggleBoard
  def initialize
      @board = []
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
       # @dice = @dice.delete(die)

    # @board = Array.new(4) {
    #  temp_board.shift(4).join
    # }

    @board = [
              %w(A W D E),
              %w(B O J O),
              %w(C R O P),
              %w(F D K P)
          ]
  end
  # Defining to_s on an object controls how the object is
  # represented as a string, e.g., when you pass it to puts
  #
  # Override this to print out a sensible board format so
  # you can write code like:
  #
  # board = BoggleBoard.new
  # board.shake!
  # puts board
  def to_s
    if @board == []
      "----\n----\n----\n----"
    else
      "#{@board[0]}\n#{@board[1]}\n#{@board[2]}\n#{@board[3]}"
    end
  end

  def include?(word)
    #check word length
    characters = word.length
    letters = word.chars

      #p @board.class
      @board.each do |x|

        x.each_with_index {|val,index|
         #byebug
          if val.upcase == letters[0].upcase #first character
            p index + x
          end
        }
      end
  end
end

board = BoggleBoard.new
board.shake!
#puts board
board.include?("word")




