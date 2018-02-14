class CreateBooks < ActiveRecord::Migration[5.1]
  def change
    create_table :books do |t|
      t.string :title
      t.integer :year_published
      t.string :language
      t.string :status
      t.integer :borrower #will store foreign_key id of user that is borrower
      t.integer :user_id #this is book owner
    end
  end
end
