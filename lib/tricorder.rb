# = A Domain-Specific Language for Star Trek API (http://stapi.co)
#
# Homepage::  http://github.com/jjuliano/tricorder
# Author::    Joel Bryan Juliano
# Copyright:: (cc) 2018 Joel Bryan Juliano
# License::   GNU LGPLv3
#
require 'rubygems'
require 'byebug'
require 'uri'
require 'net/http'
require 'awesome_print'
require 'json'
require 'pstore'

require_relative 'version'

Dir[File.join(File.dirname(__FILE__), '**/**/*.rb')].sort.reverse.each { |lib| require lib }
