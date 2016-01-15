class AddUriToCreators < ActiveRecord::Migration
  def change
    add_column(:creators, :uri, :string)
  end
end
