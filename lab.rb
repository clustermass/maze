require "byebug"
class Grid
attr_accessor :grid, :start, :finish
  def initialize(size)
    @size = size
    @grid = Array.new(size) {Array.new(size)}
    @start = [1,2]
    @finish = [size,size - 1]
  end

  def create_lab
    @size.times do |idx|
      self[1,idx] = "w"
      self[idx,1] = "w"
    end
    @size.times do |idx|
      self[@size,idx] = "w"
      self[idx,@size] = "w"
    end
    self[1,2] = nil
    self[@size,@size-1] = nil

    12.times do |idx|
      self[5,idx] = "w"
      self[11,@size - idx] = "w"
    end

    self[@start.first,@start.last] = "S"
    self[@finish.first, @finish.last] = "F"
  end

  def []=(x,y,value)
    unless y > @grid.length || x > @grid.length
      @grid[-1 * y][x-1] = value
    end
  end

  def [](x,y)
    unless y > @grid.length || x > @grid.length
     @grid[-1 * y][x-1]
    end
  end

  def prnt
    output = ""
    @grid.each_with_index do |row,idx|
      @grid.each_with_index do |pos,idx2|
        if @grid[idx][idx2] == nil
          output << "[]"
        elsif @grid[idx][idx2] == "w"
          output << "██"
        else
          output << @grid[idx][idx2] + " "
        end
      end
      output << "\n"
    end
    print output
  end

  def clone_grid
    grid = Array.new(@grid.length)
    grid.each_index {|idx| grid[idx] = @grid[idx].dup}
    clone_grid = self.class.new(@grid.size)
    clone_grid.grid = grid
    clone_grid
  end
end

class Pathfinder

  def initialize(grid)
    @grid = grid
  end

  def find_path
    @temp_grid ||= @grid.clone_grid
    @temp_grid.prnt
  end


end


if $PROGRAM_NAME == __FILE__
 g = Grid.new(15)
 g.create_lab
 pf = Pathfinder.new(g)
 pf.find_path
 # cloned.prnt
 # p g[1,2]
end
