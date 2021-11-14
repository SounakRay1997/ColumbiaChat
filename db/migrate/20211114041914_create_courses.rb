class CreateCourses < ActiveRecord::Migration[6.0]
  def change
    create_table :courses do |t|
      t.string :course_code
      t.string :course_title
      t.string :class_id
      t.string :course_subtitle
      t.string :department
      t.string :department_code

      t.timestamps
    end
  end
end
