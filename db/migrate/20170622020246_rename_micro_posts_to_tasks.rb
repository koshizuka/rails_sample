class RenameMicroPostsToTasks < ActiveRecord::Migration
  def change
    rename_table :microposts, :tasks
  end
end
