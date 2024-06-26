# frozen_string_literal: true

class AddMoreFieldsToMovies < ActiveRecord::Migration[7.0]
  def change
    add_column(:movies, :director, :string)
    add_column(:movies, :duration, :string)
    add_column(:movies, :image_file_name, :string)
  end
end
