class PackageDefinitionsConverter
  def initialize(entries)
    @entries = entries
  end
  
  def run
    @entries.collect { |e| PuppetPackageDefinition.new(e) }
  end
end
