class ChangeBadges < ActiveRecord::Migration[6.0]
  def change
    remove_foreign_key :badges, :categories
    remove_column :badges, :level
    add_column :badges, :rule_value, :string, null: false, default: ''
  end
end
