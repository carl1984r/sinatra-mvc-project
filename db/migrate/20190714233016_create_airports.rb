class CreateAirports < ActiveRecord::Migration[5.2]
  def change
    create_table :airports do |t|
     t.string :airport_code
     t.string :airport_name
     t.belongs_to :user, index: true
    end
  end
end
