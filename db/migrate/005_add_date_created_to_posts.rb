
class AddDateCreatedToPosts < ActiveRecord::Migration[6.0]

    def change
        add_column :posts, :created_at, :datetime
    end

end