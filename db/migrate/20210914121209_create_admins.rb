class CreateAdmins < ActiveRecord::Migration[6.1]
  def change
    create_table :admins do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.string :hobby_id, array: true, default: []
      t.string :address

      t.timestamps
    end
  end
end
