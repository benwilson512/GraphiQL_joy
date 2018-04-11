defmodule GraphiqlJoy.Schema do
  @moduledoc "Schema definitions for web-based GraphQL requests"

  use Absinthe.Schema
  require Logger
  
  object :account do
    field(:username, :string)
  end

  object :secondary_auth_result do
    field(:something_interesting, :string)
  end

  query do
    @desc "Would retrieve the current user's account information if this weren't fake"
    field :account, :account do
      fn (_args, _context) -> %{username: "Slartibartfast"} end
    end
  end

  subscription do
    @desc """
    Initiates an external authentication and notifies 
    the client will be told when the authentication completes
    """
    field :secondary_authentication, :secondary_auth_result do
      arg(:username, :string)
      arg(:password, :string)

      config fn(args, _context) ->
        Logger.debug "secondary auth config function called: #{inspect(args)}"
        {:ok, topic: "secondary_auth:username"}
      end
    end
  end
end
