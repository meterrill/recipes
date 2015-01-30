class CreateTableCategories < ActiveRecord::Migration
  def change
    create_table(:categories) do |t|
      t.column(:name, :string)
      t.column(:recipe_id, :integer)

      t.timestamps
    end
  end
end
