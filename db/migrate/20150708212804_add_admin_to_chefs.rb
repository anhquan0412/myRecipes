class AddAdminToChefs < ActiveRecord::Migration
  def change
    add_column :chefs, :admin, :boolean, default: false #the first default type
  end
end
