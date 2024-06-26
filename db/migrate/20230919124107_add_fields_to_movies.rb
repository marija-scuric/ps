# frozen_string_literal: true

class AddFieldsToMovies < ActiveRecord::Migration[7.0]
  def up
    add_column(:movies, :description, :text)
    add_column(:movies, :released_on, :date)
  end

  def down
    remove_column(:movies, :description)
    remove_column(:movies, :released_on)
  end
end
