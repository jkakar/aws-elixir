defmodule AWS.Client.EnvironmentProvider do
  @behaviour AWS.Client.Provider

  alias AWS.Client

  def client(%Client{} = initial_client \\ %Client{}) do
    Client.merge(initial_client, credentials_from_environment)
  end

  defp credentials_from_environment do
    %Client{
      access_key_id: get_env(
        ~w(AWS_ACCESS_KEY_ID AMAZON_ACCESS_KEY_ID AWS_ACCESS_KEY)),
      secret_access_key: get_env(
        ~w(AWS_SECRET_ACCESS_KEY AMAZON_SECRET_ACCESS_KEY AWS_SECRET_KEY)),
      token: get_env(
        ~w(AWS_SESSION_TOKEN AMAZON_SESSION_TOKEN)),
      region: get_env(
        ~w(AWS_REGION))
    }
  end

  defp get_env(keys) when is_list(keys) do
    Enum.reduce keys, nil, fn(key, acc) ->
      case {acc, System.get_env(key)} do
        {a, _b} when not is_nil(a) -> a
        {nil, b} when not is_nil(b) -> b
        _ -> nil
      end
    end
  end
end
