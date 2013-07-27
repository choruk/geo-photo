class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.decimal :latitude, :precision => 15, :scale => 10
      t.decimal :longitude, :precision => 15, :scale => 10

      t.timestamps
    end
  end
end
