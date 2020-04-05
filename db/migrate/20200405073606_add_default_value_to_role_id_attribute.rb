class AddDefaultValueToRoleIdAttribute < ActiveRecord::Migration[5.2]
  def change
  	    # change_column :users, :role, :integer, default: Role.find_by_name('user').id
  	    change_column_default :users, :role_id, from: nil, to: Role.find_by_name('user').id

  end
end
