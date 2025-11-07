defmodule Tes.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :text, :string
      add :body, :string

      timestamps()
    end
  end
end
