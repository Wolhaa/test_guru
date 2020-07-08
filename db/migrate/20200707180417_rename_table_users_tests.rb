class RenameTableUsersTests < ActiveRecord::Migration[6.0]
  def change
    rename_table :users_tests, :tests_users
  end
end
