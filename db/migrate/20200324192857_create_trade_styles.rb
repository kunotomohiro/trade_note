class CreateTradeStyles < ActiveRecord::Migration[6.0]
  def change
    create_table :trade_styles do |t|
      t.string :name
      t.timestamps
    end
  end
end
