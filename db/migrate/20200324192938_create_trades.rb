class CreateTrades < ActiveRecord::Migration[6.0]
  def change
    create_table :trades do |t|
      t.references :user, foreign_key: true
      t.references :trade_style, foreign_key: true
      t.references :trade_category, foreign_key: true
      t.boolean    :result, null: false, default: false
      t.float      :pips, null: false, default: 0
      t.text       :content
      t.datetime   :entry_time
      t.datetime   :exit_time
      t.timestamps
    end
  end
end
