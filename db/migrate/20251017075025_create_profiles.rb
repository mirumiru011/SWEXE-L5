class CreateProfiles < ActiveRecord::Migration[8.0]
  def change
    create_table :profiles do |t|
      t.text :introduction
      t.string :location
      t.references :user, null: false, foreign_key: true # user_id カラムと外部キー制約

      t.timestamps
    end
  end
end
