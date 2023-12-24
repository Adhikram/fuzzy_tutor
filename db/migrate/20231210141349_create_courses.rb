class CreateCourses < ActiveRecord::Migration[7.0]
  def change
    create_table :courses do |t|
      t.string :name, null: false, default: 'Temp Courses'
      t.string :description
      t.boolean :active_status, default: false
      t.integer :course_type, default: 0
      t.string :slug, null: false
      t.index :slug, unique: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end

    add_index :courses, :course_type
  end
end
