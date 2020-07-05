class AddUsersTestConstraint < ActiveRecord::Migration[6.0]
  def change
    change_column_null(:users_tests, :user_id, false)
    change_column_null(:users_tests, :test_id, false)
  end
end
