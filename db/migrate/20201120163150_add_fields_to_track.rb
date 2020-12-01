class AddFieldsToTrack < ActiveRecord::Migration[6.0]
  def change
    add_column :tracks, :goal, :float, default: 0
    add_column :tracks, :category, :string, default: 'other'
    add_column :tracks, :last_record, :float, default: 0
  end
end
