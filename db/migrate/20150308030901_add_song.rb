class AddSong < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.string :name, :normalized_name
      t.text   :body
    end

    add_reference :songs, :artist, index: true
  end
end
