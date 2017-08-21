class AddAuthorToTickets < ActiveRecord::Migration
  def change
    add_reference :tickets, :author, index: true
    # associate column author_id to users table
    add_foreign_key :tickets, :users, column: :author_id
  end
end
