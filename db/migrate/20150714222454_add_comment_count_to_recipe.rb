class AddCommentCountToRecipe < ActiveRecord::Migration
  def change
    add_column :recipes, :commentcount, :integer
  end
end
