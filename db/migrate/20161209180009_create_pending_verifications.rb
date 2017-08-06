class CreatePendingVerifications < ActiveRecord::Migration[5.0]
  def change
    create_table :pending_verifications do |t|
      t.string :root
      t.string :domain

      t.timestamps
    end
  end
end
