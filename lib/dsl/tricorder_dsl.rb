require_relative 'operators/base_operators'
require_relative 'tricorder'

class TricorderDSL < BaseOperators::BaseDSLOperators
  include BaseOperators

  def initialize
    @error = false
    @results = []
    @search = []
    @operations = {}
    @page = 0
    @verbose = true
    @storedir = '/tmp'
    @tricorder = nil
    @info = {}
  end

  def method_missing(method, *args)
    @operations[method] = args
    self
  end
end
