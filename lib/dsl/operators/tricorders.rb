Dir[File.join(File.dirname(__FILE__), 'tricorders/**/*.rb')].sort.reverse.each { |tricorder| require_relative tricorder }

module Tricorders
  TRICORDERS = %i[animal comic_strip
                 element material
                 season technology
                 astronomical_object comics
                 episode medical_condition
                 series title
                 book food movie
                 soundtrack trading_card
                 book_collection company
                 occupation
                 spacecraft trading_card_deck
                 book_series conflict
                 literature organization
                 spacecraft_class trading_card_set
                 character
                 location performer
                 video_game
                 comic_collection
                 magazine platform
                 species video_release
                 comic_series
                 magazine_series reference
                 staff weapon].freeze

  include Animal
  include AstronomicalObject
  include Book
  include BookCollection
  include BookSeries
  include Characters
  include ComicCollection
  include ComicSeries
  include ComicStrip
  include Comics
  include Company
  include Conflict
  include Element
  include Episode
  include Food
  include Literature
  include Location
  include Magazine
  include MagazineSeries
  include Material
  include MedicalCondition
  include Movie
  include Occupation
  include Organization
  include Performer
  include Season
  include Series
  include Soundtrack
  include Spacecraft
  include SpacecraftClass
  include Species
  include Staff
  include Technology
  include Title
  include TradingCard
  include TradingCardDeck
  include TradingCardSet
  include VideoGame
  include VideoRelease
  include Weapon
end
