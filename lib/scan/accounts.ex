defmodule Scan.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias Scan.Repo

  alias Scan.Accounts.User
  alias Scan.Accounts.Camera
  alias Scan.Accounts.Plate

  def get_user!(id), do: Repo.get!(User, id)
  def get_resource_by_id(id), do: Repo.get(User, id)

  def create(params) do
    params
    |> User.signup_changeset()
    |> Repo.insert()
  end

  def get_user_by_email(email) do
    User
    |> where(email: ^email)
    |> Repo.one()
    |> case do
      nil -> :error
      user -> {:ok, user}
    end
  end

  @doc """
  camera
  """
  def list_camera(user_id) do
    Camera
    |> where(user_id: ^user_id)
    |> Repo.all()
  end

  def create_camera(params) do
    params
    |> Camera.create_changeset()
    |> Repo.insert()
  end

  def get_camera_by_id(id) do
    Camera
    |> where(id: ^id)
    |> Repo.one()
    |> case do
      nil -> :error
      camera -> {:ok, camera}
    end
  end

  def update_camera(camera, params) do
    camera
    |> Camera.update_changeset(params)
    |> Repo.update()
  end

  @doc """
  plate
  """
  def create_plate(params) do
    params
    |> Plate.create_changeset()
    |> Repo.insert()
  end
end
