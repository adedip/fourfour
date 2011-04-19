class Board < ActiveRecord::Base

  serialize :squares

  belongs_to :user_one, :class_name => "User", :foreign_key => :user_one
  belongs_to :user_two, :class_name => "User", :foreign_key => :user_two

  before_save :init_squares

  def init_squares
    if squares
      self.squares = "[],[],[],[]"
    end
    #squares = [[],[],[],[]]
  end

  def self.available
    Board.find_by_user_two nil
  end

  def move user, x, y
    x = x.to_i
    y = y.to_i
    if x < 4 && y < 4
      unless squares[x][y]
        squares[x][y] = user.id
      end
    end
  end

  def winner_or_pair
    unless remain
      if count_squares(user_one) > count_squares(user_two)
        user_one
      elsif count_squares(user_one) < count_squares(user_two)
        user_two
      else
        nil
      end
    end
  end

  def remain
    16 - squares.flatten.length
  end

  def count_squares user
    squares.flatten.rindex user
  end

end
