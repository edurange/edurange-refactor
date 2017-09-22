class CreateCourseStudents < ActiveRecord::Migration[5.1]
  def change
    create_table :course_students do |t|
      t.timestamps
      t.integer :course_id
      t.integer :student_id
    end

    add_index :course_students, [:course_id, :student_id]
  end
end
