class Divs < ActiveRecord::Migration
    
  def change
    create_table :divs do |t|
        t.column :text, :string, :null => false
        t.column :weight, :integer
    end
  end



end
