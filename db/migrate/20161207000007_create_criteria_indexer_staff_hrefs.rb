class CreateCriteriaIndexerStaffHrefs < ActiveRecord::Migration[5.0]
  def change
    create_table :criteria_indexer_staff_hrefs do |t|
      t.string :term

      t.timestamps
    end
  end
end
