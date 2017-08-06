class CreateIndexerTerms < ActiveRecord::Migration[5.0]
  def change
    create_table :indexer_terms do |t|
      t.string :category
      t.string :sub_category
      t.string :criteria_term
      t.string :response_term
      t.string :criteria_count
      t.string :response_count

      t.timestamps
    end
  end
end
