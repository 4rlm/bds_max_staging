class AddColumnsToCores21 < ActiveRecord::Migration[5.0]
  def change
      add_column :cores, :sfdc_url_redirect, :string
  end
end
