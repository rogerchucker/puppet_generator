module PuppetGenerator
  module PuppetHelper
    def puppet_class_name(string)
      string.sub(/.pp$/, '' ).camelcase.downcase
    end

    def puppet_module_name(string)
      string.sub(/.pp$/, '' ).camelcase.downcase
    end

    def puppet_module_path(string)
      string.underscore
    end

    def puppet_manifest_path(string)
      string.underscore + '.pp'
    end
  end
end
