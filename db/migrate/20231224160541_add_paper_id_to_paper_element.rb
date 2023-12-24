class AddPaperIdToPaperElement < ActiveRecord::Migration[7.0]
  def change
    add_column :paper_elements, :paper_id, :int
  end
end
