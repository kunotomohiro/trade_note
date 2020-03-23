class CreateUserProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :user_profiles do |t|
      t.references :user, foreign_key: true
      t.string :nickname, default: "", null: false
      t.timestamps
    end
  end
end
