class ChangeTypeInStaffers < ActiveRecord::Migration[5.0]
  def change
      change_column(:staffers, :sfdc_cont_influence, :string)
      change_column(:staffers, :site_cont_influence, :string)
  end
end
