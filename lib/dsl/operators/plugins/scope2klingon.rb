require_relative '../../tricorder'
require_relative '../../tricorder_dsl'
require_relative 'pIqaD​_alphabet'

module Scope2Klingon
  include PiqadAlphabet

  def scope2klingon
    @scope2klingon = true
    @output = []
    return unless @object.is_a?(String)

    output = @object.scan(/.{1}/)

    output.each_with_index do |val, idx|
      @output[idx] = KLINGON_LETTERS[val.upcase.to_sym]
    end

    puts @output.join(' ')
  end
end
