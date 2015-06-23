class AddLikeCountToRecipe < ActiveRecord::Migration
  def change
    add_column :recipes, :likecount, :integer
  end
end
