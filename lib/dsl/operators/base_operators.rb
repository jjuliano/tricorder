require_relative 'tricorders'
require_relative 'plugins'

module BaseOperators
  include Tricorders

  class BaseDSLOperators
    attr_reader :page

    def set_subject(name)
      @subject = name

      self
    end

    def api_key(key)
      @api_key = key
      self
    end

    def set_tricorder(name)
      @tricorder = name.to_sym
      self
    end

    def init_error_messages
      if @tricorder.nil? || !Tricorders::TRICORDERS.include?(@tricorder)
        ap "Invalid Tricorder Name! #{@tricorder}"
        ap "Set the correct tricorder via 'set_tricorder(name)'"
        ap "Tricorders can either be #{Tricorders::TRICORDERS}"
        @error = true
      end

      if @subject.nil?
        ap 'No Subject Defined!'
        ap "Set a subject via 'set_subject(name)'"
        @error = true
      end

      exit(0) if @error
    end

    def no_logging
      @verbose = false
      self
    end

    def preprocessor(*preprocessors)
      @preprocessors = preprocessors.flatten

      self
    end

    def log(message, options = {})
      return unless options[:verbose] || @verbose

      if options[:pager]
        self.send(options[:pager], message)
      else
        ap(message)
      end
    end

    def set_path(path)
      @path = path
      self
    end

    def set_storedir(path)
      @storedir = path
    end

    def params
      {
        apiKey: @api_key,
        pageSize: 1000
      }
    end

    def set_collection(collection)
      exit(0) if @error

      @collection = collection
      self
    end

    def search_locations(*tricorders)
      exit(0) if @error

      tricorders.flatten.each do |location|
        self.send("search_#{location.to_s}".to_sym)
      end

      self
    end

    def merge_results
      exit(0) if @error

      @results = @results.inject(:merge)
      self
    end

    def get_result_number(num)
      exit(0) if @error

      begin
        @result = @results[num - 1]
        set_uid(@result['uid'])
      rescue
        ap "No results found!"
        @error = true
      end

      self
    end

    def set_uid(uid)
      exit(0) if @error

      @uid = uid

      self
    end

    def print_only_once
      @print_only_once = true

      self
    end

    def fetch_info
      exit(0) if @error

      response = Net::HTTP.get(URI.parse(@path + "?uid=#{@uid}"))

      @info = JSON.parse(response)

      @info[@tricorder.to_s].each_key do |key,val|
        @info[@tricorder.to_s].compact!
        @info[@tricorder.to_s].delete_if { |_k, v| v == false }
        if @info[@tricorder.to_s][key].is_a?(Array)
          @info[@tricorder.to_s][key].each_with_index do |_, index|
            @info[@tricorder.to_s][key][index].compact!
            @info[@tricorder.to_s][key][index].delete_if { |_k, v| v == false }
          end
        end
      end
    end

    def set_format(type)
      formats = [:raw, :plain, :json, :html]

      if formats.include?(type.to_sym)
        @format = type.to_sym
      else
        ap "Invalid format #{@format}. Valid formats are #{formats.join(', ')}"
        @error = true
      end

      self
    end

    def search
      exit(0) if @error

      log "Searching '#{humanized_tricorder_name}' databank for '#{@subject}'..."

      search_params = params.merge(
        name: @subject,
        title: @subject,
        description: @subject
      )

      response = Net::HTTP.post_form(URI.parse(@path + '/search'), search_params)

      @search << JSON.parse(response.body)

      if @search[0].key?('code')
        ap @search[0]['code']
        @error = true
      end

      @search.flatten!

      count = @search.count

      0.upto(count).each do |c|
        next if @search.nil? || @search[c].nil? || @search[c][@collection].nil?
        @results << @search[c][@collection]
        @results.flatten!
        @results.each_with_index do |result, index|
          result.compact!
          result.delete_if { |_k, v| v == false }
          @results[index] = result
        end
      end

      self
    end

    def humanized_tricorder_name
      exit(0) if @error

      init_error_messages

      @tricorder.to_s.split('_').map(&:capitalize).join(' ')
    end

    def printer(object)
      exit(0) if @error

      init_error_messages

      @object = object

      if object.empty?
        ap "No info found!"
      else
        if @preprocessors
          @preprocessors.each do |preprocessor|
            self.send(preprocessor.to_sym) unless self.instance_variable_get("@#{preprocessor}".to_sym)
          end
        else
          print_object
        end
      end
    end

    def print_info(*fields)
      collection, field, number = fields.flatten
      num = 0 || number

      @results.each do |res|
        set_uid(res['uid'])

        fetch_info
        begin
          info = @info[@tricorder.to_s]

          print_info = if field
            info[collection][num][field]
          else
            info[collection]
          end

          if @print_only_once
            @out ||= print_info
          else
            @out = print_info
          end

          printer(@out) unless @printed

          @printed = true if @print_only_once
        rescue
          log "Collection not found or empty"
          log "Available collections are #{@info.delete_if { |_k, v| v == false || v.is_a?(Array) && v&.empty? }.keys.join(", ")}"
        end
      end

      self
    end

    def print_all_info
      @results.each do |result|
        set_uid(result['uid'])

        fetch_info
        printer(@info)
      end

      self
    end

    def print_result
      printer(@result)

      self
    end

    def print_all_results
      printer(@results)

      self
    end
  end
end
