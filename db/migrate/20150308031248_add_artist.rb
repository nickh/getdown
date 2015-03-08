class AddArtist < ActiveRecord::Migration
  def change
    create_table :artists do |t|
      t.string :name, :normalized_name
    end

    add_index :artists, :normalized_name
  end
end
