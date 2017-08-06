class CreateInTextDels < ActiveRecord::Migration[5.0]
  def change
    create_table :in_text_dels do |t|
      t.string :term

      t.timestamps
    end
  end
end
