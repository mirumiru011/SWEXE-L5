class ReplacePassWithPasswordDigestInUsers < ActiveRecord::Migration[8.0]
  def change
    remove_column :users, :pass, :string
    add_column :users, :password_digest, :string
  end
end
