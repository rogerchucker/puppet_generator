describe Models::EntryConverter do
  before(:each) do
    Models::EntryConverter.clear
  end

  it "raises an error if an entry converter is invalid: missing method \"convert\"" do
    test_class = Class.new( Models::EntryConverter ) do

      def self.library_name
        "PuppetGenerator"
      end

      def self.model_name
        "EntryConverter"
      end

      def self.path_to_instances
        File.join( examples_dir, 'entry_converter', 'missing_method.rb' )
      end

      def self.require_path(name)
        File.join( examples_dir, 'entry_converter', 'missing_method' )
      end
    end

    expect {
      test_class.init
    }.to raise_error Exceptions::InvalidEntryConverter
  end
#
#  it "finds an importer for a file" do
#    Models::Importer.init
#
#    expected_result = Models::Importer.find( :file )
#    result = Models::Importer.find( reads_from: File.join(examples_dir, 'importer', 'test_file.txt' ) )
#    expect(result).to eq(expected_result)
#  end
#
#  it "finds an importer for a directory" do
#    Models::Importer.init
#
#    expected_result = Models::Importer.find( :directory )
#    result = Models::Importer.find( reads_from: File.join(examples_dir, 'importer', 'test.d' ) )
#    expect(result).to eq(expected_result)
#  end
#
#  it "finds an importer for stdin" do
#    Models::Importer.init
#
#    expected_result = Models::Importer.find( :stdin )
#    result = Models::Importer.find( reads_from: 'stdin' )
#    expect(result).to eq(expected_result)
#  end
#
#  it "reads from file" do
#    Models::Importer.init
#
#    importer = Models::Importer.find( :file )
#    result = importer.read(File.join(examples_dir, 'importer', 'test_file.txt' ))
#    expect(result).to eq([ 'asdf' ] )
#  end
#
end
