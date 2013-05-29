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
    
    #raised if source is empty
    class EmptySource < Exception; end
    
    #raised if an unknown input filter was
    #requested by the user
    class UnknownImportFilter < Exception; end
    
    #raised if an unknown action was
    #requested by the user
    class UnknownAction < Exception; end
    
    #raised if an error happened during decoding of yaml
    class InvalidYamlInput < Exception; end
    
    #raised if an error happened during decoding of passwd
    class InvalidPasswdInput < Exception; end
    
    #raised if an error happened during copying files
    class ErrorDuringCopyFiles < Exception; end
  end
end
