class AddIndexToLeadCards < ActiveRecord::Migration
  def change
    change_column :cards, :lead, :boolean, default: false
    add_index :cards, :lead
  end
end
