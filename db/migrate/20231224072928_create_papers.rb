class CreatePapers < ActiveRecord::Migration[7.0]
  def change
    create_table :papers do |t|
      t.string :title
      t.string :description
      t.boolean :active_status, default: false
      t.string :resource_link
      t.string :slug, null: false
      t.integer :paper_type
      t.references :course, null: false, foreign_key: true
      t.references :user, foreign_key: true, optional: true
      t.references :paper_element, foreign_key: true, optional: true

      t.timestamps
    end
    add_column :paper_elements, :paper_id, :int
  end
end
