module PuppetGenerator
  module ImportFilters
    class Passwd
      def convert(lines)
        lines.collect do |line|
          passwd = line.split(/:/)
          raise Exceptions::InvalidPasswdInput if passwd.size < 7

          (username,_,uid,gid,_,homedir,shell) = passwd

          { 
            name: username,
            userid: uid,
            groupid: gid,
            homedir: homedir,
            shell: shell,
          }
        end
      end
    end
  end
end
