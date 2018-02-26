require_relative '../../tricorder'
require_relative '../../tricorder_dsl'
require_relative 'pIqaD_alphabet'

module Name2Klingon
  include PiqadAlphabet

  def name2klingon
    @name2klingon = true
    @output = []

    output = @results[0]['name'].scan(/.{1}/)

    output.each_with_index do |val, idx|
      @output[idx] = KLINGON_LETTERS[val.upcase.to_sym]
    end

    puts @output.join(' ')
  end
end
