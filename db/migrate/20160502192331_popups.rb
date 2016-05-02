class Popups < ActiveRecord::Migration
  def change
    def change
        create_table :popups do |t|
            t.column :text, :string, :null => false
        end
    end
  end
end
