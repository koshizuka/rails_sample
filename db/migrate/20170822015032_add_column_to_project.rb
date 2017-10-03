class AddColumnToProject < ActiveRecord::Migration
  def change
    add_column :projects, :start_date, :Date
  end
end
