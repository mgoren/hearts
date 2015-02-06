class AddLeadToCards < ActiveRecord::Migration
  def change
    add_column :cards, :lead, :boolean
  end
end
