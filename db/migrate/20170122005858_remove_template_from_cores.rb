class RemoveTemplateFromCores < ActiveRecord::Migration[5.0]
  def change
      remove_column :cores, :template, :string
  end
end
