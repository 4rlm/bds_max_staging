class RemoveColumnFromStaffers < ActiveRecord::Migration[5.0]
  def change
      remove_column :staffers, :sfdc_cont_inactive, :string
  end
end
