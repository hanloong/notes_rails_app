class CreateTermsAndConditions < ActiveRecord::Migration
  def change
    create_table :terms_and_conditions do |t|
      t.string :title
      t.text :body

      t.timestamps
    end
  end
end
