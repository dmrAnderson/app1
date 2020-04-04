# frozen_string_literal: true

class AddActivationTokenToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :activation_token, :string
    add_column :users, :activated, :boolean, default: false
  end
end
