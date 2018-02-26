require_relative '../../tricorder'
require_relative '../../tricorder_dsl'

module PrintObject
  def printobject
    case @format
    when :plain
      ap @object
    when :json
      ap @object, indent: 2,
                  index: false,
                  multiline: true,
                  plain: true,
                  raw: true,
                  sort_keys: true,
                  sort_vars: true
    when :html
      ap @object, html: true
    when :raw
      puts @object
    end
  end
  alias_method :print_object, :printobject
end
