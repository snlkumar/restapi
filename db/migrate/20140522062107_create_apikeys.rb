class CreateApikeys < ActiveRecord::Migration
  def change
    create_table :apikeys do |t|
      t.string :token
      t.references :user
      t.timestamps
    end
  end
end
