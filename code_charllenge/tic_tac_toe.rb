

#game_data is an array of hashes
def is_winer(game_data, player_name)
  row_align_count = [0, 0, 0]
  col_align_count = [0, 0, 0]
  diagonal_align_count = [0, 0]
  align_stat = [ row_align_count, col_align_count, diagonal_align_count]
  is_win = false
  
  game_data.each_index do |row|
    if game_data[row]
      game_data[row].each do |col, player|
        #p col, player
        col = col.to_i
        if player == player_name
          row_align_count[row] += 1
          col_align_count[col] += 1
          #check for diagnoals
          if row == col
            diagonal_align_count[0] += 1
          end
          if row + col == row_align_count.size - 1
            diagonal_align_count[1] += 1
          end
        end
      end
    end 
  
  end #end of checking all he elm in the game
  align_stat.each do |align_stytle|
    align_stytle.each do |alignment_cnt|
      if alignment_cnt == row_align_count.size #support n X n grids, it is 3 in this csae
        is_win = true
        break
      end
    end
    break if is_win == true
  end
 
  p align_stat
  is_win
end



if $0 == __FILE__
game = [
  {"0" => "p2", "1"=>"p1" , "2"=>"p2"},
  {"0" => "p1" , "2"=>"p2"},
  {"0" => "p2", "1"=>"p1" , "2"=>"p2"},
]

p is_winer(game, "p2")
end