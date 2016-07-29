class TestCase
  attr_accessor :naomi_block_weights, :ken_block_weights

  def initialize(n_blks, k_blks)
    @naomi_block_weights = string_to_blocks(n_blks)
    @ken_block_weights = string_to_blocks(k_blks)
  end

  private

  def string_to_blocks(blk_string)
    blk_string.chomp.split(' ').map(&:to_f)
  end
end

class DataSet
  def initialize(path)
    @path = path
  end

  def self.build(size)
    raise ArgumentError unless %w(small test large).include?(size.to_s)
    new(File.expand_path("../#{size}-data-set.txt", __FILE__))
  end

  def cases
    @cases ||= read_cases
  end

  private

  def read_cases
    lines = input_lines.dup
    case_count = lines.shift.to_i
    lines.each_slice(3).map do |_blk_cnt, n_blks, k_blks|
      TestCase.new(n_blks, k_blks)
    end.tap do |cases|
      fail 'case count miss match, bad input?' unless cases.length == case_count
    end
  end

  def input_lines
    @input_lines ||= File.readlines(@path).map(&:chomp)
  end
end
