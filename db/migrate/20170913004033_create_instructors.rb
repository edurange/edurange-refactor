class CreateInstructors < ActiveRecord::Migration[5.1]
  def change
    create_table :instructors do |t|
  		t.timestamps
      t.integer :user_id
    end
    
    add_index :instructors, :user_id
    add_foreign_key :instructors, :users, dependent: :delete
  end
end
