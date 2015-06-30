class AddPasswordDigestToChefs < ActiveRecord::Migration
  def change
    add_column :chefs, :password_digest, :string
    # it has to be named 'password_digest'
  end
end
