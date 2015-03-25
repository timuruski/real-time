Class.new(Sequel::Migration) do
  def up
    create_table :candidates do
      primary_key :id
      Integer :poll_id
      String :name
      Integer :votes
    end
  end

  def down
    drop_table :candidates
  end
end
