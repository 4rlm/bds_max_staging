class ChangeTypeForSfdcTierToString < ActiveRecord::Migration[5.0]
  def change
        change_column(:cores, :sfdc_tier, :string)
  end
end
