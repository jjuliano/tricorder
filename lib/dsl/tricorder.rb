require_relative 'tricorder_dsl'
require_relative 'operators/string'

module Tricorder
  BASE_URL = 'http://stapi.co/api/v1/rest'.freeze
  def tricorder(&block)
    tricorder = TricorderDSL.new
    tricorder.instance_eval(&block) if block_given?
  end
end
