class CreateCriteriaIndexerLocTexts < ActiveRecord::Migration[5.0]
  def change
    create_table :criteria_indexer_loc_texts do |t|
      t.string :term

      t.timestamps
    end
  end
end
