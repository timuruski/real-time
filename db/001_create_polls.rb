Class.new(Sequel::Migration) do
  def up
    create_table :polls do
      primary_key :id
      String :name
    end
  end

  def down
    drop_table :polls
  end
end
