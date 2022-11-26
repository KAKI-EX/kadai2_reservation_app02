class ChangeCloumnsNotnullAddUsers < ActiveRecord::Migration[6.0]
  def change
    change_column :users, :avatar, :string, null: true
  end
end
