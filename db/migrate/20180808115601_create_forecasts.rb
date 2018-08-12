class CreateForecasts < ActiveRecord::Migration[5.1]
  def change
    create_table :forecasts do |t|
      t.string :city
      t.string :condition, array: true
      t.string :max_temp, array: true
      t.string :min_temp, array: true
      t.string :precipitation, array: true
      t.string :user_id
      t.string :email
      t.timestamps
    end
  end
end
