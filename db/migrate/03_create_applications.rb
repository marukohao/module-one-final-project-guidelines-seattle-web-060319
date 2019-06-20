class CreateApplications < ActiveRecord::Migration[5.0]
  def change
    create_table :applications do |t|
      t.integer :job_id
      t.integer :user_id
      t.string :title
      t.string :company
      t.string :location
    end
  end

end
