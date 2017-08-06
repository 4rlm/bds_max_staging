class RenameColumnsInIndexers2 < ActiveRecord::Migration[5.0]
  def change
      rename_column :indexers, :reported, :bug
      rename_column :indexers, :report_note, :bug_note

      add_column :indexers, :flagged_note, :string
      add_column :cores, :flagged_note, :string
      add_column :cores, :bug_note, :string      
  end


end
