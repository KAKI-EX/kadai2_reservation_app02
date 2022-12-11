class CreateUserprofiles < ActiveRecord::Migration[6.0]
  def change
    create_table :userprofiles do |t|
      t.integer :user_id,      null: false, default: ""
      t.text :self_introduce,null: true, default:""
      t.string :user_name,     null: true, default:""
      t.string :user_avatar,     null: true, default:""
      
      t.timestamps
    end
  end
end
