module PuppetGenerator
  module Filter
    class EtcPasswd
      def convert(lines)
        lines.collect do |line|
          (username,_,uid,gid,_,homedir,shell) = line.split(/:/)

          { 
            username: username,
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
