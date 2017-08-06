class AddPhonesToIndexer < ActiveRecord::Migration[5.0]
  def change
      add_column :indexers, :phones, :string, array: true, default: []
  end
end
