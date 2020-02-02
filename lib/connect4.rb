class Game
  

  def initialize
    @game_hash = { 
      a1: nil, a2: nil, a3: nil, a4: nil, a5: nil, a6: nil, a7: nil,
      b1: nil, b2: nil, b3: nil, b4: nil, b5: nil, b6: nil, b7: nil,
      c1: nil, c2: nil, c3: nil, c4: nil, c5: nil, c6: nil, c7: nil,
      d1: nil, d2: nil, d3: nil, d4: nil, d5: nil, d6: nil, d7: nil,
      e1: nil, e2: nil, e3: nil, e4: nil, e5: nil, e6: nil, e7: nil,
      f1: nil, f2: nil, f3: nil, f4: nil, f5: nil, f6: nil, f7: nil,
    }
  end

  def game_script
    puts "Welcome to Connect4. Who will go first?  Enter \"S\" for soccer ball or \"B\" for baseball."
    valid_input = false
    while valid_input == false
      first_move = gets.chomp.downcase
      valid_input = true if (first_move == 's' || first_move == 'b')
    end
    if first_move == "b"
      i = 1
    else
      i = 2
    end
    while evaluate_game == false
      if i.even?
        turn('s')
      else
        turn('b')
      end
      i += 1
    end
    winner = evaluate_game unless false
    puts `clear`
    board_print
    case winner
    when 's'
      puts "Soccer won!"
    when 'b'
      puts "Baseball won!"
    when 'tie'
      puts "Nobody won - Baseball and Soccer tied!"
    end
  end

  def turn(var)
    turn_complete = false
    puts `clear`
    board_print
    if var == 'b'
      long_var_name = "baseball"
    elsif var == 's'
      long_var_name = "soccer ball"
    end
    while turn_complete == false
      puts "In which column (1-7) would you like to place a \"#{long_var_name}\"?"
      player_input = gets.chomp
      if token_drop(var, player_input) != false
        turn_complete = true
      end
    end
  end

  def token_drop(icon, column)
    num_nil = 0
    @game_hash.each do |key, value |
      num_nil += 1 if value.nil? && key[1] == column
    end
    case num_nil
    when 0
      return false
    when 1
      cell = ("f" + column).to_sym
    when 2
      cell = ("e" + column).to_sym
    when 3
      cell = ("d" + column).to_sym
    when 4
      cell = ("c" + column).to_sym
    when 5
      cell = ("b" + column).to_sym
    when 6
      cell = ("a" + column).to_sym
    end
    update_hash(icon, cell) unless cell.nil?
    return cell
  end

  def update_hash(icon, *cells)
    cells.each do |cell|
      @game_hash[cell] = icon
    end
  end

  def board_print
    board_hash = {}
    @game_hash.each do |key, value|
      if value.nil?
        board_hash[key] = "    "
      elsif value == "b"
        board_hash[key] = " \u26BE " 
      elsif value == "s"
        board_hash[key] = " \u26BD "
      end
    end
    
    print """

           1    2    3    4    5    6    7
        ╔════╤════╤════╤════╤════╤════╤════╗
      F ║#{board_hash[:f1]}│#{board_hash[:f2]}│#{board_hash[:f3]}│#{board_hash[:f4]}│#{board_hash[:f5]}│#{board_hash[:f6]}│#{board_hash[:f7]}║
        ╟────┼────┼────┼────┼────┼────┼────╢
      E ║#{board_hash[:e1]}│#{board_hash[:e2]}│#{board_hash[:e3]}│#{board_hash[:e4]}│#{board_hash[:e5]}│#{board_hash[:e6]}│#{board_hash[:e7]}║
        ╟────┼────┼────┼────┼────┼────┼────╢
      D ║#{board_hash[:d1]}│#{board_hash[:d2]}│#{board_hash[:d3]}│#{board_hash[:d4]}│#{board_hash[:d5]}│#{board_hash[:d6]}│#{board_hash[:d7]}║
        ╟────┼────┼────┼────┼────┼────┼────╢
      C ║#{board_hash[:c1]}│#{board_hash[:c2]}│#{board_hash[:c3]}│#{board_hash[:c4]}│#{board_hash[:c5]}│#{board_hash[:c6]}│#{board_hash[:c7]}║
        ╟────┼────┼────┼────┼────┼────┼────╢
      B ║#{board_hash[:b1]}│#{board_hash[:b2]}│#{board_hash[:b3]}│#{board_hash[:b4]}│#{board_hash[:b5]}│#{board_hash[:b6]}│#{board_hash[:b7]}║
        ╟────┼────┼────┼────┼────┼────┼────╢
      A ║#{board_hash[:a1]}│#{board_hash[:a2]}│#{board_hash[:a3]}│#{board_hash[:a4]}│#{board_hash[:a5]}│#{board_hash[:a6]}│#{board_hash[:a7]}║
        ╚════╧════╧════╧════╧════╧════╧════╝

    """
  end

  def evaluate_game
    temp = []
    @game_hash.each do | key, value |
      temp.push(check_horizontal(key, value))
      temp.push(check_vertical(key, value))
      temp.push(check_diagonal_left(key, value))
      temp.push(check_diagonal_right(key, value))
    end
    if temp.include?("b")
      return "b"
    elsif temp.include?("s")
      return "s"
    elsif board_full? == true
      return "tie"
    else
      return false
    end
  end
  
      def board_full?
        temp = 0
        @game_hash.each do | key, value |
          temp += 1 if !value.nil?
        end
        if temp == 42
          return true
        else
          return  false
        end
      end

      def check_horizontal(key, value)
        temp = []
        temp.push(value)
        temp.push(@game_hash[num_spaces_right(key, 1)])
        temp.push(@game_hash[num_spaces_right(key, 2)])
        temp.push(@game_hash[num_spaces_right(key, 3)])
        if temp == ["b", "b", "b", "b"]
          return "b"
        elsif temp == ["s", "s", "s", "s"]
          return "s"
        else
          return false
        end
      end
  
      def check_vertical(key, value)
        temp = []
        temp.push(value)
        temp.push(@game_hash[num_spaces_up(key, 1)])
        temp.push(@game_hash[num_spaces_up(key, 2)])
        temp.push(@game_hash[num_spaces_up(key, 3)])
        if temp == ["b", "b", "b", "b"]
          return "b"
        elsif temp == ["s", "s", "s", "s"]
          return "s"
        else
          return false
        end
      end

      def check_diagonal_right(key, value)
        temp = []
        temp.push(value)
        temp.push(@game_hash[num_spaces_diag_right(key, 1)])
        temp.push(@game_hash[num_spaces_diag_right(key, 2)])
        temp.push(@game_hash[num_spaces_diag_right(key, 3)])
        if temp == ["b", "b", "b", "b"]
          return "b"
        elsif temp == ["s", "s", "s", "s"]
          return "s"
        else
          return false
        end
      end

      def check_diagonal_left(key, value)
        temp = []
        temp.push(value)
        temp.push(@game_hash[num_spaces_diag_left(key, 1)])
        temp.push(@game_hash[num_spaces_diag_left(key, 2)])
        temp.push(@game_hash[num_spaces_diag_left(key, 3)])
        if temp == ["b", "b", "b", "b"]
          return "b"
        elsif temp == ["s", "s", "s", "s"]
          return "s"
        else
          return false
        end
      end

      def num_spaces_right(location, num)
        if location[1].to_i + num < 8
          return (location[0] + (location[1].to_i + num).to_s).to_sym
        else
          return false
        end
      end
      
      def num_spaces_left(location, num)
        if location[1].to_i - num > 0
          return (location[0] + (location[1].to_i - num).to_s).to_sym
        else
          return false
        end
      end
      
      def num_spaces_up(location, num)
        row = ('a'..'f').to_a
        if row.index(location[0]) + num < 7
          return (row[row.index(location[0]) + num].to_s + location[1]).to_sym
        else
          return false
        end
      end

      def num_spaces_diag_left(location, num)
        row = ('a'..'f').to_a
        if row.index(location[0]) + num < 7 && location[1].to_i - num > 0
          return (row[row.index(location[0]) + num].to_s + (location[1].to_i - num).to_s).to_sym
        else
          return false
        end
      end

      def num_spaces_diag_right(location, num)
        row = ('a'..'f').to_a
        if row.index(location[0]) + num < 7 && location[1].to_i + num < 8
          return (row[row.index(location[0]) + num].to_s + (location[1].to_i + num).to_s).to_sym
        else
          return false
        end
      end

end

game = Game.new
game.game_script