class Board < ActiveRecord::Base

  serialize :squares

  belongs_to :user_one, :class_name => "User", :foreign_key => :user_one
  belongs_to :user_two, :class_name => "User", :foreign_key => :user_two

  def self.available
    Board.find_by_user_two nil
  end

  def move user, x, y
    self.squares = [] unless self.squares
    x = x.to_i
    y = y.to_i
    if x < 4 && y < 4
      if squares[x]
        unless squares[x][y]
          squares[x][y] = user.id
        end
      else
        squares[x] = []
        squares[x][y] = user.id
      end
    end
  end

  def winner_or_pair
    if remain == 0
      if count_squares(self.user_one.id) > count_squares(self.user_two.id)
        sb.elf.user_one.nickname
      elsif count_squares(self.user_one.id) < count_squares(self.user_two.id)
        self.user_two.nickname
      else
        nil
      end
    end
  end

  def remain
    16 - squares.flatten.compact.length
  end

  def count_squares user
    squares.flatten.compact.count(user).to_i
  end

end
