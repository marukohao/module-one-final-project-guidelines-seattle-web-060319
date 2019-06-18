class CreateJobs < ActiveRecord::Migration[5.2]
 def change
    create_table :jobs do |t|
      t.string :company
      t.string :location
      t.string :description
      t.boolean :type
      t.string :created_at
      t.string :title
    end
  end
end

