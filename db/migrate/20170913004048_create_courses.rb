class CreateCourses < ActiveRecord::Migration[5.1]
  def change
    create_table :courses do |t|
      t.timestamps
      t.integer :instructor_id
      t.string  :name, null: false
      t.string  :registration_code, null: false
      t.boolean :registration_open, default: true
    end

    add_index :courses, :instructor_id
    add_foreign_key :courses, :instructors, dependent: :delete
  end
end
