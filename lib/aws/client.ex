defmodule AWS.Client do
  @moduledoc """
  Access and connections details needed when making requests to AWS services.
  """

  defstruct access_key_id: nil,
            secret_access_key: nil,
            token: nil,
            region: nil,
            endpoint: "amazonaws.com",
            service: nil,
            expires_at: nil

  @type t :: %AWS.Client{}

  @spec merge(AWS.Client.t, AWS.Client.t) :: AWS.Client.t
  def merge(a, b) do
    Map.merge a, b, fn
      (_k, v1, nil) ->
        v1
      (_k, _v1, v2) ->
        v2
    end
  end
end
