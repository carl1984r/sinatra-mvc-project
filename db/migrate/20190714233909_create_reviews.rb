class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
     t.string :content
     t.timestamps(null: false)
     t.belongs_to :airport, index: true
   end
  end
end
