class AddBaseValueToStatistics < ActiveRecord::Migration
  def change
    add_column :statistics, :base_value, :float
  end
end
