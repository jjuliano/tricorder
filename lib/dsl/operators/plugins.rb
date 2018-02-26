Dir[File.join(File.dirname(__FILE__), 'plugins/**/*.rb')].sort.reverse.each { |plugin| require_relative plugin }

module Tricorders
  include Name2Klingon
  include Scope2Klingon
  include PrintObject
end
