class CreateSolitaries < ActiveRecord::Migration[5.0]
  def change
    create_table :solitaries do |t|
      t.string :solitary_root
      t.string :solitary_url

      t.timestamps
    end
  end
end
