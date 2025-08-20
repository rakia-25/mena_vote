class AddColumnToCandidate < ActiveRecord::Migration[7.0]
  def change
    add_column :candidates, :category, :string
    add_column :candidates, :category_rank, :integer
    add_column :candidates, :vote_code, :string
    add_column :candidates, :name, :string
  end
end
