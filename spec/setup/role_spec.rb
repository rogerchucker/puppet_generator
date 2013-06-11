describe Setup::Role do
  it "enables default values" do
    s = Setup::Role.new( HashWithIndifferentAccess.new )
    s.setup_environment

    expect(Models::ImportFilter.find_all(enabled: true).size).to eq(2)
    expect(Models::Template.find_all(enabled: true).size).to eq(1)
    expect(Models::Action.find_all(enabled: true).size).to eq(1)
    expect(Models::Importer.find_all(enabled: true).size).to eq(3)
    expect(Models::ExportFilter.find_all(enabled: true).size).to eq(1)

  end
end
