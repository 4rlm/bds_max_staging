class RemoveColumnsFromGcses < ActiveRecord::Migration[5.0]
    def change
        remove_column :gcses, :url_encoded, :string
        remove_column :gcses, :in_text_neg, :string
        remove_column :gcses, :in_host_neg, :string
        remove_column :gcses, :in_suffix_del, :string
        remove_column :gcses, :in_host_del, :string
    end
end
