class CreateInTextPos < ActiveRecord::Migration[5.0]
  def change
    create_table :in_text_pos do |t|
      t.string :term

      t.timestamps
    end
  end
end
