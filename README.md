# PuppetGenerator User Documentation

[![Build Status for master branch](https://travis-ci.org/maxmeyer/puppet_generator.png?branch=master)](https://travis-ci.org/maxmeyer/puppet_generator)
[![Code Climate](https://codeclimate.com/github/maxmeyer/puppet_generator.png)](https://codeclimate.com/github/maxmeyer/puppet_generator)

Writing [Puppet](https://www.puppetlabs.com)-manifests made easy... 

## Description

Writing manifests for puppet can be very time consuming and quite boring. The
`puppet_generator` reduces the amount of time for writing puppet manifests a lot
by generating a basic structure for:

* User resources
* Package resources
* File resources
* ...

This project can help you if you:

* have a lot manifests to write
* simple manifests to write
* need a skeleton to start with

This project __cannot__ help you if you:

* have few but (very) complex manifests to write
* have no fun in using new tools ;-)

## Installation

Add this line to your application's Gemfile:

    gem 'puppet_generator'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install puppet_generator

## Usage

### Basics

The puppet generator comes with a single executable called `ppgen`. It uses a syntax
similar to git. 

```
ppgen <command> [options] <subcommand> [suboptions] 
```

To get help, please call it with `help` as parameter or `--help|-h` as option.

*Example:*

```
ppgen help
ppgen help <command>
ppgen <command> help <subcommand>
ppgen --help
ppgen -h
```

In general it supports some other special options. A better description for all other options is given below and is 
available via the `help`-command as well.

* `--debug`: Gives you very detailed debug output
* `--silent`: Makes it silent

*Example:*

```
ppgen <command> <subcommand> --debug
```

*Example:*

```
ppgen <command> <subcommand> --silent
```

Besides the given options `ppgen` provides a way to define the name of the
module and the class name for the given resource used to create the output

* Module name: `--module`
* Class name: `--class`

*Example:*

```
#command
ppgen <command> <subcommand> --module mymodule --class myclass

# output
class mymodule::myclass {

[...]

}
```

### Data flow

The flow of data through `ppgen` is described in the following figure. Today it
reads data data via an importer (1) first -- there's no streaming support
available. After the import filter the data via the import filter (2) and then
the export filter (3). To output the filtered data `ppgen` uses a suitable
exporter (4). 

__Please note:__

Available options for (1), (2), (3), (4) and (5) may depend on the chosen command
and/or subcommand.

*Figure:*

```
Input --> Importer --> ImportFilter --> ExportFilter --> Action --> Exporter --> Output
            (1)           (2)               (3)           (4)         (5)
```

### All Available Options for Importer, Import|ExportFilter, Action, Exporter 

`ppgen` supports the following importers:

* File: Read data from a file
* Directory: Generate a listing for a directory and use all items (directory/file) found
* Stdin: Read data from stdin

Which importer to use is determined via `<input>`. If it's a file the `File`-importer is used and so on.

*Example*

```
ppgen <command> <subcommand> --source <input>
ppgen <command> <subcommand> --source file.txt
ppgen <command> <subcommand> --source dir.d
ppgen <command> <subcommand> --source stdin
```

`ppgen` supports the following import filters:

* Null (`null`, default): Import plain text data
* Yaml (`yaml`): Import [YAML](http://www.yaml.org) documents
* Passwd (`passwd`): Import structured data from `/etc/passwd` (linux/unix-operating
  systems only)

*Example*

```
ppgen <command> <subcommand> --import-filter <filter>
ppgen <command> <subcommand> --import-filter null
ppgen <command> <subcommand> --import-filter yaml
ppgen <command> <subcommand> --import-filter passwd
```

`ppgen` supports the following export filters:

* Null (`null`, default): No modification of data
* Filesystem attributes (`filesystem_attributes`): It tries to read filesystem attributes like owner,
  mode etc. from the filesystem
* Build role for directory (`build_role_includes_for_directory`): Special export filter which scans a directory for
  `*.pp` and generates a `<dir'>.pp` including the sub-pp-files

*Example*

```
ppgen <command> <subcommand> --export-filter <filter>
ppgen <command> <subcommand> --export-filter null
ppgen <command> <subcommand> --export-filter filesystem_attributes
ppgen <command> <subcommand> --export-filter build_role_includes_for_directory
```

`ppgen` supports the following actions:

* Null (`null`, default): no action
* Copy files to module (`copy_files_to_module_directory`): Given a module name (default: mymodule) it copies existing files to a directory `<module>`

*Example*

```
ppgen <command> <subcommand> --action <action>
ppgen <command> <subcommand> --action null
ppgen <command> <subcommand> --action copy_files_to_module_directory
```

`ppgen` supports the following exporters:

* File (`file`): Store output in a single file
* Directory (`dir|directory`): Store output in multiple files (name = equals name of resource,  user => hans, name => hans.pp)
* Stdout (`stdout`): Output data to stdout

*Example*

```
ppgen <command> <subcommand> --destination <destination>
ppgen <command> <subcommand> --destination file:file.txt
ppgen <command> <subcommand> --destination dir:dir1.d
ppgen <command> <subcommand> --destination directory:dir1.d
ppgen <command> <subcommand> --destination stdout
```


It supports `create`, `list` (not implemented yet) and `show`(not implemented
yet)-commands, as well as the special `tasks`-command. The last one should make
the usage easier. Instead of giving `ppgen` all needed options it is a shortcut
for some options so that you need to provide a `--source` and a
  `--destination`-option only.

Please use the following command to get an overview about the available
resource which can be created

```bash
ppgen help create
```

## Data formats

If you chose to use the yaml import filter, the following YAML-file-formats are
supported for the `create`-command.

### User

```
---
user1:
  userid: 1000
  groupid: 1000
  homedir: /home/user1
  shell: /usr/bin/bash
```

### Package

```
---
ssh:
  version: 1
  provider: yum
```


### File

```
---
path/to/file:
  type:file
  source: puppet:///module/file.txt
  owner: user1
  mode: 0644
```

### Role

```
---
horray:
  includes:
    - name1
    - name2
```


## Use cases

### Create user manifests from plain text file and writing it to a file

Input: `file.txt`

```
user1
user2
```

Command:

```
ppgen create user --source file.txt --destination file:output.txt
```

Output: `output.txt`

```
class mymodule::myclass {
  user {'user1':
    ensure     => present,
    managehome => true,
  }
  user {'user2':
    ensure     => present,
    managehome => true,
  }
}
```

### Create user manifests from a yaml file writing it to stdout

Input: `file.yml`

```
---
user1:
  userid: 1000
  groupid: 1000
  homedir: /home/user1
  shell: /usr/bin/bash
```

Command:

```
ppgen create user --source file.yml --destination file:output.txt --import-filter yaml
```

Output: `output.txt`

```
class mymodule::myclass {
  user {'user1':
    ensure     => present,
    managehome => true,
    uid        => '1000',
    gid        => '1000',
    home       => '/home/user1',
    shell      => '/usr/bin/bash',
  }
}
```

### Create module skeleton

Command:

```
ppgen create module --module name
```

Output: Directory `name`

```
name/
|-- files
`-- manifests
    `-- init.pp
```

### Create roles for existing pp-files

**Please note**:
You should run this command only on VCS-enabled module directories (e.g.
git,cvs,svn,bazar,mercurial). It may overwrite existing role-files (e.g.
directory = 'dir1', role-file = 'dir1.pp').

Input:

```
name
|-- files
`-- manifests
    |-- apps
    |   |-- firefox.pp
    |   |-- i3.pp
    |   `-- mutt.pp
    `-- init.pp
```

Command:

```
cd name/manifests
ppgen create role --export-filter build_role_includes_for_directory --source apps --destination dir:./
```

Output: file `apps.pp`

```
name
|-- files
`-- manifests
    |-- apps
    |   |-- firefox.pp
    |   |-- i3.pp
    |   `-- mutt.pp
    |-- apps.pp        <--- NEW
    `-- init.pp

```

### Create package manifests from plain text file and writing it to stdout

Input: `file.txt`

```
package1
package2
```

Command:

```
ppgen create package --source file.txt --destination stdout
```

Output: `output.txt`

```
class mymodule::myclass {
  package {'package1':
    ensure   => installed,
  }
  package {'package2':
    ensure   => installed,
  }
}
```

## Tipps & Tricks

### Remote access to filesystem

Some of `ppgen` commands and/or options need filesystem access. If you try to
migrate a server and it's not possible to install the `puppet_generator` onto
the old one, `sshfs` may help you. Please consult the manual of `sshfs` to make
it work. 

### Jump Server Infrastructure

To make your life in an infrastructure with a jump server easier, you could use
the following ssh setup, which can be used with sshfs as well (recommened for
the use with sshfs by the author of this manual)! Given the following
infrastructure:

```
linux/unit work station --> jump server --> target server
```

You build up a ssh connection from the workstation (1) to the jump server (2).

```
linux/unit work station ====== jump server
         (1)             ssh       (2)
```

Furthermore: You build up a tcp connection from the jump server (2) to the target
server (3).

```
                               jump server ****** target server
                                   (2)       tcp       (3)
```

Done this way you have a connection like the following one in the next figure.

```
linux/unit work station ====== jump server ****** target server
                         ssh                 tcp          
```

Then you instruct ssh to use this connection for another ssh connection: from
the workstation to the target server. This works by using the first connection
as proxy connection via the ssh proxy command (see below).

```
                                   ssh
linux/unit work station ------------------------- target server
         (1)                  (jump server)            (3)
```

To get this up and running you should use a ssh configuration similar to the following one: File `$HOME/.ssh/config`:

```
Host jump_server
Hostname jump_server.example.com
User user
ForwardAgent yes 
IdentityFile ~/.ssh/id_rsa

Host target_server
Hostname target_server.example.com
User admin
ForwardAgent yes
IdentityFile ~/.ssh/id_rsa
ProxyCommand ssh user@jump_server "socat - TCP4:%h:%p"       <--- most important line
```

Furthermore you need to install a utitilty which is able to bridge STDIN to TCP
like `socat` or `netcat`. Personally I prefer `socat` because from my point of
view it's the most flexible tool for this type of task.

## Development

Please see the [developer-documentation](README.DEVELOPER.md) for more details.

## Copyright

&copy; 2013 Max Meyer and Contributors. All rights reserved. Please see [Licence](LICENSE.md).

## Contributers

* Dennis Günnewig (VR Netze GmbH, https://www.vrnetze.de)

