class AddSiteTemplateToCores < ActiveRecord::Migration[5.0]
  def change
    add_column :cores, :site_template, :string
  end
end
