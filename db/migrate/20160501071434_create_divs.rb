class CreateDivs < ActiveRecord::Migration
  def change
    drop_table :divs
    create_table :divs do |t|
        t.column :text, :string, :null => false
        t.column :weight, :integer
    end
  end
end
