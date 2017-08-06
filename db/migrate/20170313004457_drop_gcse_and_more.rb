class DropGcseAndMore < ActiveRecord::Migration[5.0]
    def change
        drop_table :gcses
        drop_table :pending_verifications
        drop_table :solitaries
        drop_table :in_host_dels
        drop_table :in_text_dels
        drop_table :exclude_roots
    end
end
