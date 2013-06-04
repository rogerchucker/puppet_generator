module PuppetGenerator
  module Middleware
    module ReadInputHelper

      private

      def is_directory?(item)
        FileTest.directory? item
      end

      def is_file?(item)
        FileTest.file? item
      end

      def is_stdin?(item)
        item == 'stdin'
      end

    end
  end
end
