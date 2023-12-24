class CreatePaperElements < ActiveRecord::Migration[7.0]
  def change
    create_table :paper_elements do |t|
      t.integer :element_type
      t.text :text
      t.text :link
      t.integer :marks
      t.integer :negative_marks
      t.string :meta_data
      t.references :parent, foreign_key: { to_table: :paper_elements, on_delete: :cascade }


      t.timestamps
    end
  end
end


