# PuppetGenerator

[![Build Status](https://travis-ci.org/maxmeyer/puppet_generator.png?branch=master)](https://travis-ci.org/maxmeyer/puppet_generator)
[![Code Climate](https://codeclimate.com/github/maxmeyer/puppet_generator.png)](https://codeclimate.com/github/maxmeyer/puppet_generator)

Writing [Puppet](https://www.puppetlabs.com)-manifests made easy... 

## Description

Writing manifests for puppet can be very time consuming and quite boring. The
PuppetGeneratore reduces the amount of time for writing puppet manifests alot
by generating a basic structure for:

* User resources
* Package resources
* File resources
* ...

This project can help you if you:

* have alot manifests to write
* simple manifests to write
* need a skeleton to start with

This project __cannot__ help you if you:

* have few very complex manifests to write
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

`ppgen` supports the following importers:

* File: Read data from a file
* Directory: Generate a listing for a directory and use all items (directory/file) found
* Stdin: Read data from stdin

`ppgen` supports the following import filters:

* Null: Import plain text data
* Yaml: Import [YAML](http://www.yaml.org) documents
* Passwd: Import structured data from `/etc/passwd` (linux/unix-operating
  systems only)

`ppgen` supports the following export filters:

* Null: No modification of data
* Filesystem attributes: It tries to read filesystem attributes like owner,
  mode etc. from the filesystem
* Build role for directory: Special export filter which scans a directory for
  `*.pp` and generates a `<dir'>.pp` including the sub-pp-files

`ppgen` supports the following actions:

* Null: no action
* Copy files to module: Given a module name (default: mymodule) it copies existing files to a directory `<module>`

`ppgen` supports the following exporters:

* File: Store output in a single file
* Directory: Store output in multiple files (name = equals name of resource,  user => hans, name => hans.pp)
* Stdout: Output data to stdout



It supports `create`, `list` and `show`-commands, as well as the special
`tasks`-command. The last one should make the usage easier. Instead of giving
`ppgen` all needed options it is a shortcut for some options so that you need
to provide a `--source` and a `--destination`-option only.

Please use the following command to get an overview about the available
resource which can be created

```bash
ppgen help create
```



### Create 

TODO: Write usage instructions here

## Tipps & Tricks

You may need to use `sshfs` to get the generator running. This way...
```
```

Ruby
Administrators not willing enough

.ssh/config
```
ProxyCommand
```

