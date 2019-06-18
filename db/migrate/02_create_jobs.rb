

class CreateJobs < ActiveRecord::Migration[5.0]
 def change
    create_table :jobs do |t|
      t.string :company
      t.string :location
      t.string :description
      t.boolean :fte
      t.string :created_at
      t.string :title
    end
  end
end
