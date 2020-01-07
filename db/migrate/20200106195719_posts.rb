class Posts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.string :email
      t.string :username
      t.string :title
      t.text :body
      t.timestamps 
      
      t.string :time
      end      
  end
end
