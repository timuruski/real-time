Sequel.migration do
  STDOUT.puts __FILE__
  up do
    create_table :polls do
      primary_key :id
      column :name, String, null: false
    end
  end

  down do
    drop_table :polls
  end
end
