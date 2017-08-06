class CreateCriteriaIndexerStaffTexts < ActiveRecord::Migration[5.0]
  def change
    create_table :criteria_indexer_staff_texts do |t|
      t.string :term

      t.timestamps
    end
  end
end
