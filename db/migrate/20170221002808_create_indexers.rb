class CreateIndexers < ActiveRecord::Migration[5.0]
  def change
    create_table :indexers do |t|
      t.string :raw_url
      t.string :redirect_status
      t.string :clean_url
      t.string :indexer_status
      t.string :staff_url
      t.string :staff_text
      t.string :location_url
      t.string :location_text
      t.string :template
      t.string :crm_id_arr, default: [], array: true

      t.timestamps
    end
  end
end
