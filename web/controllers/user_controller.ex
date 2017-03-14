defmodule PhoenixJsonApiExample.UserController do
  use PhoenixJsonApiExample.Web, :controller

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

end
