class CreateCandidateCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :candidate_categories do |t|
      t.references :candidate, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
