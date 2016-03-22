class AddPrototypeToProduct < ActiveRecord::Migration
  def change
    add_reference :products, :prototype, index: true
  end
end
