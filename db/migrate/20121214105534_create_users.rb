class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name,null: false
      t.string :uid,null: false 
      t.string :mail,null: false
      t.string :image,null: false
      t.boolean :match,default: false
      t.integer :partner_id
      t.string :follow_id
      t.boolean :wait,default: false
      t.string :follow_name
      t.string :follow_image

      t.timestamps
    end
  end
end
