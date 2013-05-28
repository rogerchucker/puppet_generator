module PuppetGenerator
  module Filter
    class EtcPasswd
      def convert(line)
        (username,-,uid,gid,-,homedir,shell) = line.split(/:/)

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
