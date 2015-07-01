class AddExpressionToStatistics < ActiveRecord::Migration
  def change
    add_column :statistics, :expression, :string
  end
end
