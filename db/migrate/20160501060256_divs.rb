class Divs < ActiveRecord::Migration
    
  def change
    create_table :divs do |t|
        t.column :text, :string, :null => false
    end
  end



end
