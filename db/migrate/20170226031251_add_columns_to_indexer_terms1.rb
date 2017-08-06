class AddColumnsToIndexerTerms1 < ActiveRecord::Migration[5.0]
  def change
      add_column :indexer_terms, :mth_name, :string      
  end
end
