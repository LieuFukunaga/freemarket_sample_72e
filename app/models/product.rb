class Product < ApplicationRecord
  belongs_to :user
  belongs_to :bland, optional: true
  belongs_to :condition
  belongs_to :category
  has_many :images  , dependent: :destroy
  has_many :comments, dependent: :destroy
  accepts_nested_attributes_for :images, allow_destroy: true

  validates :name, :explanation, :price, :shipping_days, presence: true
  validates :price, numericality: { only_integer: true , greater_than: 0, less_than: 9999999 }

  enum prefecture: {
    hokkaido:   0,
    aomori:     1,
    iwate:      2,
    miyagi:     3,
    akita:      4,
    nigata:     5,
    fukushima:  6,
    ishikawa:   7,
    fukui:      8,
    ibaraki:    9,
    tochigi:   10,
    gunma:     11,
    saitama:   12,
    chiba:     13,
    tokyo:     14,
    kanagawa:  15,
    yamagata:  16,
    toyama:    17,
    yamanashi: 18,
    nagano:    19,
    gifu:      20,
    sizuoka:   21,
    aichi:     22,
    mie:       23,
    siga:      24,
    kyoto:     25,
    ohsaka:    26,
    hyougo:    27,
    nara:      28,
    wakayama:  29,
    tottori:   30,
    shimane:   31,
    okayama:   32,
    hiroshima: 33,
    yamaguchi: 34,
    tokushima: 35,
    kagawa:    36,
    ehime:     37,
    kouchi:    38,
    fukuoka:   39,
    saga:      40,
    nagasaki:  41,
    kumamoto:  42,
    ohita:     43,
    miyazaki:  44,
    kagoshima: 45,
    okinawa:   46,
  }
end
