class AddProfileFieldsToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :f_name, :string
    add_column :users, :l_name, :string
    add_column :users, :city, :string
    add_column :users, :state, :string
    add_column :users, :phone, :string
    add_column :users, :svad_major, :string
    add_column :users, :class_stading, :string
    add_column :users, :twitter_url, :string
    add_column :users, :facebook_url, :string
    add_column :users, :linkedin_url, :string
    add_column :users, :forrst_user_name, :string
    add_column :users, :website, :string
    add_column :users, :about, :text
  end

  def self.down
    remove_column :users, :about
    remove_column :users, :website
    remove_column :users, :forrst_user_name
    remove_column :users, :linkedin_url
    remove_column :users, :facebook_url
    remove_column :users, :twitter_url
    remove_column :users, :class_stading
    remove_column :users, :svad_major
    remove_column :users, :phone
    remove_column :users, :state
    remove_column :users, :city
    remove_column :users, :l_name
    remove_column :users, :f_name
  end
end
