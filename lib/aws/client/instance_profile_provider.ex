defmodule AWS.Client.InstanceProfileProvider do
  @behaviour AWS.Client.Provider

  alias AWS.Client

  @metadata_url "http://169.254.169.254/latest/meta-data/iam/security-credentials/"
  @metadata_timeout 500

  def client(%Client{} = initial_client \\ %Client{}) do
    instance_creds = instance_profiles
    |> List.first
    |> credentials_for_profile

    case instance_creds do
      {:error, _} ->
        initial_client
      new_client ->
        Client.merge(initial_client, new_client)
    end
  end

  defp instance_profiles do
    case HTTPoison.get(@metadata_url, [], timeout: @metadata_timeout) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        String.split body, "\n"
      {:error, _} ->
        []
    end
  end

  defp credentials_for_profile(nil), do: {:error, :no_profiles}

  defp credentials_for_profile(profile) do
    url = @metadata_url <> profile
    case HTTPoison.get(url, [], timeout: @metadata_timeout) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        {:ok, payload} = Poison.decode(body)

        {:ok, expires_at} = Timex.DateFormat.parse(
          payload["Expiration"],
          "{ISOz}")

        %Client{
          access_key_id: payload["AccessKeyId"],
          secret_access_key: payload["SecretAccessKey"],
          token: payload["Token"],
          expires_at: expires_at
        }
      {:error, _} = e ->
        e
    end
  end
end
