defmodule Explorer.Application.Constants do
  @moduledoc """
    Tracks some kv info
  """

  use Explorer.Schema
  alias Explorer.{Chain, Repo}

  @keys_manager_contract_address_key "keys_manager_contract_address"

  @primary_key false
  typed_schema "constants" do
    field(:key, :string, primary_key: true, null: false)
    field(:value, :string, null: false)

    timestamps()
  end

  def changeset(attrs) do
    %__MODULE__{}
    |> changeset(attrs)
  end

  @required_attrs ~w(key value)a
  def changeset(%__MODULE__{} = constant, attrs) do
    constant
    |> cast(attrs, @required_attrs)
    |> validate_required(@required_attrs)
  end

  def get_constant_by_key(key, options) do
    __MODULE__
    |> where([constant], constant.key == ^key)
    |> Chain.select_repo(options).one()
  end

  def insert_keys_manager_contract_address(value) do
    %{key: @keys_manager_contract_address_key, value: value}
    |> changeset()
    |> Repo.insert!()
  end

  def get_keys_manager_contract_address(options \\ []) do
    get_constant_by_key(@keys_manager_contract_address_key, options)
  end
end
