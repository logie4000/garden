module SeasonsHelper

  def square_list(season)
    season.squares.map(&:name).join("; ")
  end
end
