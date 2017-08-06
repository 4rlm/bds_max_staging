class AddMatchedUrlToCores < ActiveRecord::Migration[5.0]
  def change
    add_column :cores, :matched_url, :string
  end
end
