class CreateEvents < ActiveRecord::Migration
  def change
  	create_table :events do |t|
  		t.string :title
  		t.text :description
  		t.string :address
  		t.date :event_date
  		t.string :event_time
  		t.string :price
  		t.boolean :featured
  		t.float :lattitude
  		t.float :longitude

  		t.timestamps null:false
  	end
  end
end

