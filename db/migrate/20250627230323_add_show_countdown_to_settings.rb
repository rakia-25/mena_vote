class AddShowCountdownToSettings < ActiveRecord::Migration[7.0]
  def change
    add_column :settings, :show_countdown, :string
  end
end
