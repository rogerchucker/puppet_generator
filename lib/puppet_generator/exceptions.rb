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

    #raised if one tries to delete an instance which
    #does not exist
    class InstanceNotFound < InternalError; end
    
    #raised if one tries to use an unknown error
    #message
    class UnknownErrorMessage < InternalError; end

    #raised if one tries to use a keyword whose use
    #is restricted
    class UnauthorizedUseOfKeyword < InternalError; end

    #raised if one uses invalid search criteria
    class InvalidSearchCriteria < InternalError; end
    
    #raised if one uses an invalid template
    class InvalidTemplate < InternalError; end
    
    #raised if one uses an invalid action
    class InvalidAction < InternalError; end
    
    #raised if the code which defines an import filter
    #which is malformed
    class InvalidImportFilter < InternalError; end
    
    #raised if the code which defines an importer
    #which is malformed
    class InvalidImporter < InternalError; end
    
    #raised if the code which defines an import filter
    #is malformed
    class MethodNeedsToBeImplemented < InternalError; end
    
    #raised if one tries to use an unimplemented exception
    class ExceptionNeedsToBeImplemented < InternalError; end

  end
end
