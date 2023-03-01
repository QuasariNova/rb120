# This is to help me build a generic class to log moves
class LogBook
  TABLE_WIDTH = 40
  TABLES = 2

  def initialize(idx_col_name, *columns)
    self.columns = [idx_col_name] + columns
    reset
  end

  def reset
    self.logs = []
  end

  def log(*data)
    return unless data.size == columns.size - 1
    logs << data
  end

  def display
    table = []
    table << header_to_str * TABLES
    idx = 0
    mid = (logs.size.to_f / TABLES).ceil

    while idx < mid
      row = entry_to_str idx
      1.upto(TABLES - 1) do |mul|
        id = idx + mul * mid
        row += entry_to_str id
      end

      table << row
      idx += 1
    end
    puts table
  end

  private

  attr_accessor :columns, :logs

  def entry_to_str(idx)
    return '' if idx >= logs.size
    cols = []
    cols << "| #{(idx + 1).to_s.center 3} |"
    width = column_width - 2

    logs[idx].each do |data|
      cols << " #{data.to_s[0,width].center(width)} |"
    end

    cols.join.center(TABLE_WIDTH)
  end

  def header_to_str
    cols = []
    cols << "| #{columns.first.to_s[0, 3].center 3} |"
    width = column_width - 2

    columns[1..-1].each do |label|
      cols << " #{label.to_s[0, width].center(width)} |"
    end

    cols.join.center(TABLE_WIDTH)
  end

  def column_width
    col = columns.size - 1
    width = TABLE_WIDTH - 7 - col # 7 for first column, col for separators
    width / col
  end
end

book = LogBook.new 'rnd', 'Chris', 'Hal', 'Winner'
book.log 'rock', 'scissors', 'Chris'
book.log 'paper', 'scissors', 'Hal'
book.log 'rock', 'rock', 'Tie'
book.log 'rock', 'scissors', 'Chris'
book.log 'paper', 'scissors', 'Hal'
book.log 'rock', 'rock', 'Tie'
book.log 'rock', 'scissors', 'Chris'
book.log 'paper', 'scissors', 'Hal'
book.log 'rock', 'rock', 'Tie'
book.log 'rock', 'scissors', 'Chris'
book.log 'paper', 'scissors', 'Hal'
book.log 'rock', 'rock', 'Tie'
book.log 'rock', 'scissors', 'Chris'
book.log 'paper', 'scissors', 'Hal'
book.log 'rock', 'rock', 'Tie'

book.display
