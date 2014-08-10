class CreateTerms < ActiveRecord::Migration
  def change
  	create_table :terms do |t|
      t.string :word, index: true

      t.timestamps
    end
  end
end
