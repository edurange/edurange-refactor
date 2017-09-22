class CreateStudents < ActiveRecord::Migration[5.1]
  def change
    create_table :students do |t|
      t.timestamps
      t.integer :user_id
    end
    
    add_index :students, :user_id
    add_foreign_key :students, :users, dependent: :delete
  end
end
