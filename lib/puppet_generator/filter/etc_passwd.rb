module PuppetGenerator
  module Filter
    class EtcPasswd
      def convert(line)
        (username,_,uid,gid,_,homedir,shell) = line.split(/:/)

        { 
          username: username,
          userid: uid,
          groupid: guid,
          homedir: homedir,
          shell: shell,
        }
      end
    end
  end
end
