class AddAttachmentImageToCategories < ActiveRecord::Migration[5.1]
  def change
    add_attachment :categories, :image unless column_exists? :categories, :image_file_name
  end
end
