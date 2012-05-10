class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :omniauth_provider
      t.string :omniauth_uid
      t.timestamps
    end

    add_index :users, [:omniauth_provider, :omniauth_uid]
  end
end
