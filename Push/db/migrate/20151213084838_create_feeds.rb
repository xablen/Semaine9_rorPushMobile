class CreateFeeds < ActiveRecord::Migration
  def change
    create_table :feeds do |t|
      t.string :name
      t.string :url
      t.datetime :push_date
      t.integer :app_id

      t.timestamps
    end
  end
end
