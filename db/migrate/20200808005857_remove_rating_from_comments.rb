class RemoveRatingFromComments < ActiveRecord::Migration[6.0]
  def change
    remove_column :comments, :rating
  end
end
