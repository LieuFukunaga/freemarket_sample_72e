class RemoveRegionFromProducts < ActiveRecord::Migration[5.0]
  def change
    remove_column :products, :region, :string
    add_column :products, :prefecture, :integer, default: 0, limit: 1
  end
end
