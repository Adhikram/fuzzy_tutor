class CreatePaperSubmisisons < ActiveRecord::Migration[7.0]
  def change
    create_table :paper_submisisons do |t|
      t.boolean :is_best_submission, default: false
      t.string :metadeta, default: ""
      t.string :result_metadata, default: ""
      t.integer :score, default: 0
      t.string :slug, null: false
      t.datetime :started_at
      t.datetime :submitted_at
      t.datetime :evaluated_at
      t.references :paper, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.index [:user_id, :paper_id], name: "index_paper_submisisons_on_user_id_and_paper_id"

      t.timestamps
    end
    add_column :papers, :duration, :integer, default: 60
  end
end
