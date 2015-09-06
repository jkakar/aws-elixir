defmodule AWS.Client.Provider do
  use Behaviour

  @doc "Returns a valid client struct."
  defcallback client(client :: AWS.Client.t) :: AWS.Client.t

  alias AWS.Client

  # Because we're using reduce and merge, the highest priority providers should
  # be at the bottom of the list.
  @providers [
    AWS.Client.InstanceProfileProvider,
    AWS.Client.EnvironmentProvider,
  ]

  @doc """
  Returns a client from the environment. Uses the following:

  * Environment variables (AWS_SECRET_ACCESS_KEY and AWS_ACCESS_KEY_ID)
  * EC2 Instance Profile (IAM Role) when running on an EC2 instance
  """
  @spec get_client(AWS.Client.t) :: AWS.Client.t
  def get_client(%Client{} = initial_client \\ %Client{}) do
    Enum.reduce @providers, initial_client, &(apply &1, :client, [&2])
  end
end
