module PuppetGenerator
  module Exceptions
    # exceptions raise because of a wrong usage by the user
    class UserError < Exception; end
    
    #raise if a file does not exist in filesystem
    class WrongViewChosen < UserError; end

    #raised if source is not a directory, file etc.
    class InvalidSource < UserError; end

    #raised if output channel is not directory, file etc.
    class InvalidOutputChannel < UserError; end

    #raised if template can not be found
    class TemplateNotFound < UserError; end
    
    #raised if something goes wrong internally
    #should never happend
    class InternalError < Exception; end
    
    #raised if source is empty
    class EmptySource < UserError; end

    #raised if an unknown action was
    #use in the code
    class UnknownSetup < InternalError; end
    
    #raised if an unknown input filter was
    #requested by the user
    class UnknownImportFilter < UserError; end
   
    #raised if an unknown export filter was
    #requested by the user
    class UnknownExportFilter < UserError; end
    
    #raised if an unknown action was
    #requested by the user
    class UnknownAction < UserError; end
    
    #raised if an error happened during decoding of yaml
    class InvalidYamlInput < UserError; end
    
    #raised if an error happened during decoding of passwd
    class InvalidPasswdInput < UserError; end
    
    #raised if an error happened during copying files
    class ErrorDuringCopyFiles < UserError; end
    
    #raised if an unknown model was used
    class UnknownModel < InternalError; end

    #raised if no model instances are available
    class MissingModelInstances < InternalError; end
    
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
    
    #raised if one uses an invalid view
    class InvalidView < InternalError; end
    
    #raised if one uses an invalid action
    class InvalidAction < InternalError; end
    
    #raised if the code which defines an import filter
    #which is malformed
    class InvalidImportFilter < InternalError; end
    
    #raised if the code which defines an import filter
    #which is malformed
    class InvalidExportFilter < InternalError; end
    
    #raised if the code which defines an importer
    #which is malformed
    class InvalidImporter < InternalError; end
    
    #raised if the code which defines an exporter
    #which is malformed
    class InvalidExporter < InternalError; end
    
    #raised if the code which defines a setup
    #which is malformed
    class InvalidSetup < InternalError; end
    
    #raised if the code which defines a default
    #which is malformed
    class InvalidDefault < InternalError; end
    
    #raised if the code which defines an entry converter
    #which is malformed
    class InvalidEntryConverter < InternalError; end
    
    #raised if the code which defines an import filter
    #is malformed
    class MethodNeedsToBeImplemented < InternalError; end
    
    #raised if one tries to use an unimplemented exception
    class ExceptionNeedsToBeImplemented < InternalError; end

    #raised if an file system error occured
    class FilesystemError < Exception ; end

    #raise if a directory does not exist in filesystem
    class DirectoryDoesNotExist < FilesystemError; end
    
    #raise if a file does not exist in filesystem
    class FileDoesNotExist < FilesystemError; end

  end
end
