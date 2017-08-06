class CreateInHostPos < ActiveRecord::Migration[5.0]
  def change
    create_table :in_host_pos do |t|
      t.string :term

      t.timestamps
    end
  end
end
