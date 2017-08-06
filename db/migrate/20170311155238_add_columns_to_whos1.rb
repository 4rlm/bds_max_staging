class AddColumnsToWhos1 < ActiveRecord::Migration[5.0]
  def change
      add_column :whos, :who_status, :string
      add_column :whos, :url_status, :string
  end
end
