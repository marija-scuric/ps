# typed: false
# frozen_string_literal: true

class Favorite < ApplicationRecord
  belongs_to :movie
  belongs_to :user
end
