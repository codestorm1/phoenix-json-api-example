require IEx;
require Logger;

defmodule PhoenixJsonApiExample.UserController do
  use PhoenixJsonApiExample.Web, :controller

  alias PhoenixJsonApiExample.User

  def index(conn, _params) do
    query =
      from q in PhoenixJsonApiExample.User

    data = PhoenixJsonApiExample.Repo.all(query)

    json conn, JaSerializer.format(
      PhoenixJsonApiExample.UserSerializer,
      data
    )
  end

  def show(conn, %{"id" => id}) do
    user = Repo.get!(PhoenixJsonApiExample.User, id)
    json conn, JaSerializer.format(
      PhoenixJsonApiExample.UserSerializer,
      user
    )
  end

  def new(conn, _params) do
    changeset = User.changeset(%User{})
    render(conn, "new.html", changeset: changeset)
  end

    def create(conn, %{"data" => %{ "attributes" => user_params, "type" => "user"}}) do
      changeset = User.changeset(%User{}, user_params)

      case Repo.insert(changeset) do
        {:ok, _user} ->
          conn
          #|> put_flash(:info, "User created successfully.")
          |> redirect(to: user_path(conn, :index))
        {:error, changeset} ->
          render(conn, "new.html", changeset: changeset)
      end
    end

      def update(conn, %{"data" => %{ "attributes" => user_params, "type" => "user"}, "id" => id}) do
        user = Repo.get!(User, id)
        changeset = User.changeset(user, user_params)

        case Repo.update(changeset) do
          {:ok, user} ->
            conn
            #|> put_flash(:info, "User updated successfully.")
            |> redirect(to: user_path(conn, :show, user))
          {:error, changeset} ->
            render(conn, "edit.html", user: user, changeset: changeset)
        end
      end

end
