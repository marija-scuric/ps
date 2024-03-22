# typed: false
# frozen_string_literal: true

class Characterization < ApplicationRecord
  belongs_to :movie
  belongs_to :genre
end
