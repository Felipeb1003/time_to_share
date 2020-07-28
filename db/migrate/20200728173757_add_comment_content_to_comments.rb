class AddCommentContentToComments < ActiveRecord::Migration[6.0]
  def change
    add_column :comments, :comment_content, :text
  end
end
