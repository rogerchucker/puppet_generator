module PuppetGenerator
  class Api

    def generate_package_definition_to_single_file(task)

      stack = Middleware::Builder.new do
        use ReadInputFile
        use ConvertInputToPackageDefinition
        use CreateSingleOutputFile
      end

      stack.call(task)

    end

  end
end
