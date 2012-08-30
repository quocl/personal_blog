class RemoveSlugFromPosts < ActiveRecord::Migration
  def up
    remove_column :posts, :slug
      end

  def down
    add_column :posts, :slug, :string
  end
end
