class CreateAccepts < ActiveRecord::Migration
  def change
    create_table :accepts do |t|
      t.integer :user_id
      t.string :terms_and_condition_id

      t.timestamps
    end
  end
end
