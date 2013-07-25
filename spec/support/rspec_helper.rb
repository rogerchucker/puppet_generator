def name_of_model_instances(model)
  "PuppetGenerator::Models::#{model.to_s.camelcase}".constantize.find_all( enabled: true).collect { |f| f.name }.sort
end
