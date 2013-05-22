class InputFile
  def initialize(filename)
    @entries = File.open(filename).readlines
  end

  def entries
    @entries.collect { |e| e.chomp }
  end

end

