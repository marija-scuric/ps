# typed: false
# frozen_string_literal: true

class Movie < ApplicationRecord
  RATINGS = ["G", "PG", "PG-13", "R", "NC-17"]
  has_many :reviews, -> { order(created_at: :desc) }, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :fans, through: :favorites, source: :user
  has_many :critics, through: :reviews, source: :user
  has_many :characterizations, dependent: :destroy
  has_many :genres, through: :characterizations
  validates :title, presence: true, uniqueness: true
  validates :released_on, presence: true
  validates :duration, presence: true
  validates :description, length: { minimum: 25 }
  validates :total_gross, numericality: { greater_than_or_equal_to: 0 }
  validates :image_file_name, format: {
    with: /\w+\.(jpg|png)\z/i,
    message: "must be a JPG or PNG image",
  }
  validates :rating, inclusion: { in: RATINGS }
  scope :released, -> { where("released_on < ?", Time.now).order("released_on desc") }
  scope :upcoming, lambda { where("released_on > ?", Time.now).order("released_on asc") }
  scope :recent, ->(max = 5) { released.limit(max) }
  scope :hits, -> { where("total_gross >= 300000000").order(total_gross: :desc) }
  scope :flops, -> { where("total_gross < 22500000").order(total_gross: :asc) }
  scope :grossed_less_than, ->(amount) { released.where("total_gross < ?", amount) }
  scope :grossed_greater_than, ->(amount) { released.where("total_gross > ?", amount) }
  before_save :set_slug

  def average_stars
    reviews.average(:stars).to_i || 0.0
  end

  def average_stars_as_percent
    (average_stars / 5.0) * 100
  end

  def flop?
    if reviews.count < 50 && average_stars < 4
      (total_gross.blank? || total_gross < 225000000)
    end
  end

  def to_param
    slug
  end

  # class << self
  # def self.released
  #   where("released_on < ?", Time.now).order("released_on desc")
  # end

  #   def hits
  #     where("total_gross >= 300000000").order(total_gross: :desc)
  #   end

  #   def flops
  #     where("total_gross < 22500000").order(total_gross: :asc)
  #   end

  #   def recently_added
  #     order("created_at desc").limit(3)
  #   end
  # end

  private

  def set_slug
    self.slug = title.parameterize
  end
end
