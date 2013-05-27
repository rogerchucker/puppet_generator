module PuppetGenerator
  module Exceptions
    #raised if source is not a directory, file etc.
    class InvalidSource < Exception; end

    #raised if output channel is not directory, file etc.
    class InvalidOutputChannel < Exception; end

    #raised if template can not be found
    class TemplateNotFound < Exception; end
    
    #raised if something goes wrong internally
    #should never happend
    class InternalError < Exception; end
  end
end
