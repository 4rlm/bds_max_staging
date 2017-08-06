class CreateExcludeRoots < ActiveRecord::Migration[5.0]
  def change
    create_table :exclude_roots do |t|
      t.string :term

      t.timestamps
    end
  end
end
