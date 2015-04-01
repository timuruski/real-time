Sequel.migration do
  # STDOUT.puts __FILE__
  up do
    create_table :choices do
      primary_key :id
      foreign_key :poll_id, :polls
      column :name, String, null: false
      column :votes, Integer, null: false, default: 0
    end
  end

  down do
    drop_table :choices
  end
end
