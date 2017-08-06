class AddTemplateToStaffers < ActiveRecord::Migration[5.0]
  def change
    add_column :staffers, :template, :string
  end
end
