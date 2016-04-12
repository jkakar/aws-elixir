# WARNING: DO NOT EDIT, AUTO-GENERATED CODE!
# See https://github.com/jkakar/aws-codegen for more details.

defmodule AWS.SNS do
  @moduledoc """
  Amazon Simple Notification Service

  Amazon Simple Notification Service (Amazon SNS) is a web service that
  enables you to build distributed web-enabled applications. Applications can
  use Amazon SNS to easily push real-time notification messages to interested
  subscribers over multiple delivery protocols. For more information about
  this product see [http://aws.amazon.com/sns](http://aws.amazon.com/sns/).
  For detailed information about Amazon SNS features and their associated API
  calls, see the [Amazon SNS Developer
  Guide](http://docs.aws.amazon.com/sns/latest/dg/).

  We also provide SDKs that enable you to access Amazon SNS from your
  preferred programming language. The SDKs contain functionality that
  automatically takes care of tasks such as: cryptographically signing your
  service requests, retrying requests, and handling error responses. For a
  list of available SDKs, go to [Tools for Amazon Web
  Services](http://aws.amazon.com/tools/).
  """

  @doc """
  Adds a statement to a topic's access control policy, granting access for
  the specified AWS accounts to the specified actions.
  """
  def add_permission(client, input, options \\ []) do
    request(client, "AddPermission", input, options)
  end

  @doc """
  Verifies an endpoint owner's intent to receive messages by validating the
  token sent to the endpoint by an earlier `Subscribe` action. If the token
  is valid, the action creates a new subscription and returns its Amazon
  Resource Name (ARN). This call requires an AWS signature only when the
  `AuthenticateOnUnsubscribe` flag is set to "true".
  """
  def confirm_subscription(client, input, options \\ []) do
    request(client, "ConfirmSubscription", input, options)
  end

  @doc """
  Creates a platform application object for one of the supported push
  notification services, such as APNS and GCM, to which devices and mobile
  apps may register. You must specify PlatformPrincipal and
  PlatformCredential attributes when using the `CreatePlatformApplication`
  action. The PlatformPrincipal is received from the notification service.
  For APNS/APNS_SANDBOX, PlatformPrincipal is "SSL certificate". For GCM,
  PlatformPrincipal is not applicable. For ADM, PlatformPrincipal is "client
  id". The PlatformCredential is also received from the notification service.
  For APNS/APNS_SANDBOX, PlatformCredential is "private key". For GCM,
  PlatformCredential is "API key". For ADM, PlatformCredential is "client
  secret". The PlatformApplicationArn that is returned when using
  `CreatePlatformApplication` is then used as an attribute for the
  `CreatePlatformEndpoint` action. For more information, see [Using Amazon
  SNS Mobile Push
  Notifications](http://docs.aws.amazon.com/sns/latest/dg/SNSMobilePush.html).
  """
  def create_platform_application(client, input, options \\ []) do
    request(client, "CreatePlatformApplication", input, options)
  end

  @doc """
  Creates an endpoint for a device and mobile app on one of the supported
  push notification services, such as GCM and APNS. `CreatePlatformEndpoint`
  requires the PlatformApplicationArn that is returned from
  `CreatePlatformApplication`. The EndpointArn that is returned when using
  `CreatePlatformEndpoint` can then be used by the `Publish` action to send a
  message to a mobile app or by the `Subscribe` action for subscription to a
  topic. The `CreatePlatformEndpoint` action is idempotent, so if the
  requester already owns an endpoint with the same device token and
  attributes, that endpoint's ARN is returned without creating a new
  endpoint. For more information, see [Using Amazon SNS Mobile Push
  Notifications](http://docs.aws.amazon.com/sns/latest/dg/SNSMobilePush.html).

  When using `CreatePlatformEndpoint` with Baidu, two attributes must be
  provided: ChannelId and UserId. The token field must also contain the
  ChannelId. For more information, see [Creating an Amazon SNS Endpoint for
  Baidu](http://docs.aws.amazon.com/sns/latest/dg/SNSMobilePushBaiduEndpoint.html).
  """
  def create_platform_endpoint(client, input, options \\ []) do
    request(client, "CreatePlatformEndpoint", input, options)
  end

  @doc """
  Creates a topic to which notifications can be published. Users can create
  at most 3000 topics. For more information, see
  [http://aws.amazon.com/sns](http://aws.amazon.com/sns/). This action is
  idempotent, so if the requester already owns a topic with the specified
  name, that topic's ARN is returned without creating a new topic.
  """
  def create_topic(client, input, options \\ []) do
    request(client, "CreateTopic", input, options)
  end

  @doc """
  Deletes the endpoint from Amazon SNS. This action is idempotent. For more
  information, see [Using Amazon SNS Mobile Push
  Notifications](http://docs.aws.amazon.com/sns/latest/dg/SNSMobilePush.html).
  """
  def delete_endpoint(client, input, options \\ []) do
    request(client, "DeleteEndpoint", input, options)
  end

  @doc """
  Deletes a platform application object for one of the supported push
  notification services, such as APNS and GCM. For more information, see
  [Using Amazon SNS Mobile Push
  Notifications](http://docs.aws.amazon.com/sns/latest/dg/SNSMobilePush.html).
  """
  def delete_platform_application(client, input, options \\ []) do
    request(client, "DeletePlatformApplication", input, options)
  end

  @doc """
  Deletes a topic and all its subscriptions. Deleting a topic might prevent
  some messages previously sent to the topic from being delivered to
  subscribers. This action is idempotent, so deleting a topic that does not
  exist does not result in an error.
  """
  def delete_topic(client, input, options \\ []) do
    request(client, "DeleteTopic", input, options)
  end

  @doc """
  Retrieves the endpoint attributes for a device on one of the supported push
  notification services, such as GCM and APNS. For more information, see
  [Using Amazon SNS Mobile Push
  Notifications](http://docs.aws.amazon.com/sns/latest/dg/SNSMobilePush.html).
  """
  def get_endpoint_attributes(client, input, options \\ []) do
    request(client, "GetEndpointAttributes", input, options)
  end

  @doc """
  Retrieves the attributes of the platform application object for the
  supported push notification services, such as APNS and GCM. For more
  information, see [Using Amazon SNS Mobile Push
  Notifications](http://docs.aws.amazon.com/sns/latest/dg/SNSMobilePush.html).
  """
  def get_platform_application_attributes(client, input, options \\ []) do
    request(client, "GetPlatformApplicationAttributes", input, options)
  end

  @doc """
  Returns all of the properties of a subscription.
  """
  def get_subscription_attributes(client, input, options \\ []) do
    request(client, "GetSubscriptionAttributes", input, options)
  end

  @doc """
  Returns all of the properties of a topic. Topic properties returned might
  differ based on the authorization of the user.
  """
  def get_topic_attributes(client, input, options \\ []) do
    request(client, "GetTopicAttributes", input, options)
  end

  @doc """
  Lists the endpoints and endpoint attributes for devices in a supported push
  notification service, such as GCM and APNS. The results for
  `ListEndpointsByPlatformApplication` are paginated and return a limited
  list of endpoints, up to 100. If additional records are available after the
  first page results, then a NextToken string will be returned. To receive
  the next page, you call `ListEndpointsByPlatformApplication` again using
  the NextToken string received from the previous call. When there are no
  more records to return, NextToken will be null. For more information, see
  [Using Amazon SNS Mobile Push
  Notifications](http://docs.aws.amazon.com/sns/latest/dg/SNSMobilePush.html).
  """
  def list_endpoints_by_platform_application(client, input, options \\ []) do
    request(client, "ListEndpointsByPlatformApplication", input, options)
  end

  @doc """
  Lists the platform application objects for the supported push notification
  services, such as APNS and GCM. The results for `ListPlatformApplications`
  are paginated and return a limited list of applications, up to 100. If
  additional records are available after the first page results, then a
  NextToken string will be returned. To receive the next page, you call
  `ListPlatformApplications` using the NextToken string received from the
  previous call. When there are no more records to return, NextToken will be
  null. For more information, see [Using Amazon SNS Mobile Push
  Notifications](http://docs.aws.amazon.com/sns/latest/dg/SNSMobilePush.html).
  """
  def list_platform_applications(client, input, options \\ []) do
    request(client, "ListPlatformApplications", input, options)
  end

  @doc """
  Returns a list of the requester's subscriptions. Each call returns a
  limited list of subscriptions, up to 100. If there are more subscriptions,
  a `NextToken` is also returned. Use the `NextToken` parameter in a new
  `ListSubscriptions` call to get further results.
  """
  def list_subscriptions(client, input, options \\ []) do
    request(client, "ListSubscriptions", input, options)
  end

  @doc """
  Returns a list of the subscriptions to a specific topic. Each call returns
  a limited list of subscriptions, up to 100. If there are more
  subscriptions, a `NextToken` is also returned. Use the `NextToken`
  parameter in a new `ListSubscriptionsByTopic` call to get further results.
  """
  def list_subscriptions_by_topic(client, input, options \\ []) do
    request(client, "ListSubscriptionsByTopic", input, options)
  end

  @doc """
  Returns a list of the requester's topics. Each call returns a limited list
  of topics, up to 100. If there are more topics, a `NextToken` is also
  returned. Use the `NextToken` parameter in a new `ListTopics` call to get
  further results.
  """
  def list_topics(client, input, options \\ []) do
    request(client, "ListTopics", input, options)
  end

  @doc """
  Sends a message to all of a topic's subscribed endpoints. When a
  `messageId` is returned, the message has been saved and Amazon SNS will
  attempt to deliver it to the topic's subscribers shortly. The format of the
  outgoing message to each subscribed endpoint depends on the notification
  protocol selected.

  To use the `Publish` action for sending a message to a mobile endpoint,
  such as an app on a Kindle device or mobile phone, you must specify the
  EndpointArn. The EndpointArn is returned when making a call with the
  `CreatePlatformEndpoint` action. The second example below shows a request
  and response for publishing to a mobile endpoint.
  """
  def publish(client, input, options \\ []) do
    request(client, "Publish", input, options)
  end

  @doc """
  Removes a statement from a topic's access control policy.
  """
  def remove_permission(client, input, options \\ []) do
    request(client, "RemovePermission", input, options)
  end

  @doc """
  Sets the attributes for an endpoint for a device on one of the supported
  push notification services, such as GCM and APNS. For more information, see
  [Using Amazon SNS Mobile Push
  Notifications](http://docs.aws.amazon.com/sns/latest/dg/SNSMobilePush.html).
  """
  def set_endpoint_attributes(client, input, options \\ []) do
    request(client, "SetEndpointAttributes", input, options)
  end

  @doc """
  Sets the attributes of the platform application object for the supported
  push notification services, such as APNS and GCM. For more information, see
  [Using Amazon SNS Mobile Push
  Notifications](http://docs.aws.amazon.com/sns/latest/dg/SNSMobilePush.html).
  """
  def set_platform_application_attributes(client, input, options \\ []) do
    request(client, "SetPlatformApplicationAttributes", input, options)
  end

  @doc """
  Allows a subscription owner to set an attribute of the topic to a new
  value.
  """
  def set_subscription_attributes(client, input, options \\ []) do
    request(client, "SetSubscriptionAttributes", input, options)
  end

  @doc """
  Allows a topic owner to set an attribute of the topic to a new value.
  """
  def set_topic_attributes(client, input, options \\ []) do
    request(client, "SetTopicAttributes", input, options)
  end

  @doc """
  Prepares to subscribe an endpoint by sending the endpoint a confirmation
  message. To actually create a subscription, the endpoint owner must call
  the `ConfirmSubscription` action with the token from the confirmation
  message. Confirmation tokens are valid for three days.
  """
  def subscribe(client, input, options \\ []) do
    request(client, "Subscribe", input, options)
  end

  @doc """
  Deletes a subscription. If the subscription requires authentication for
  deletion, only the owner of the subscription or the topic's owner can
  unsubscribe, and an AWS signature is required. If the `Unsubscribe` call
  does not require authentication and the requester is not the subscription
  owner, a final cancellation message is delivered to the endpoint, so that
  the endpoint owner can easily resubscribe to the topic if the `Unsubscribe`
  request was unintended.
  """
  def unsubscribe(client, input, options \\ []) do
    request(client, "Unsubscribe", input, options)
  end

  @spec request(map(), binary(), map(), list()) ::
    {:ok, Poison.Parser.t | nil, Poison.Response.t} |
    {:error, Poison.Parser.t} |
    {:error, HTTPoison.Error.t}
  defp request(client, action, input, options) do
    client = %{client | service: "sns"}
    host = get_host("sns", client)
    url = get_url(host, client)
    headers = [{"Host", host},
               {"Content-Type", "application/x-amz-json-"},
               {"X-Amz-Target", ".#{action}"}]
    payload = Poison.Encoder.encode(input, [])
    headers = AWS.Request.sign_v4(client, "POST", url, headers, payload)
    case HTTPoison.post(url, payload, headers, options) do
      {:ok, response=%HTTPoison.Response{status_code: 200, body: ""}} ->
        {:ok, nil, response}
      {:ok, response=%HTTPoison.Response{status_code: 200, body: body}} ->
        {:ok, Poison.Parser.parse!(body), response}
      {:ok, _response=%HTTPoison.Response{body: body}} ->
        error = Poison.Parser.parse!(body)
        exception = error["__type"]
        message = error["message"]
        {:error, {exception, message}}
      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, %HTTPoison.Error{reason: reason}}
    end
  end

  defp get_host(endpoint_prefix, client) do
    if client.region == "local" do
      "localhost"
    else
      "#{endpoint_prefix}.#{client.region}.#{client.endpoint}"
    end
  end

  defp get_url(host, %{:proto => proto, :port => port}) do
    "#{proto}://#{host}:#{port}/"
  end

end
