class CreateTableSpiesMarks < ActiveRecord::Migration
  def change
    create_table :marks_spies, id: false do |t|
      t.belongs_to :mark, index: true
      t.belongs_to :spy, index: true
    end
  end
end
