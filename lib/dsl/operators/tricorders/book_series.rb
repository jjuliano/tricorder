require_relative '../../tricorder'
require_relative '../../tricorder_dsl'

module BookSeries
  RESOURCE_NAME = 'bookSeries'.freeze
  COLLECTION_NAME = 'bookSeries'.freeze
  NAME = RESOURCE_NAME.underscore
  API_PATH = Tricorder::BASE_URL + "/#{RESOURCE_NAME}"

  private_constant :API_PATH, :RESOURCE_NAME, :COLLECTION_NAME, :NAME

  define_method("search_#{NAME}".to_sym) do
    set_tricorder(NAME.to_sym)
    set_collection(COLLECTION_NAME)
    set_path(API_PATH)
    search
    self
  end
end
