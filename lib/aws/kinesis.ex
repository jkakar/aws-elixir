# WARNING: DO NOT EDIT, AUTO-GENERATED CODE!
# See https://github.com/jkakar/aws-codegen for more details.

defmodule AWS.Kinesis do
  @moduledoc """
  Amazon Kinesis Service API Reference

  Amazon Kinesis is a managed service that scales elastically for real time
  processing of streaming big data.
  """

  @doc """
  Adds or updates tags for the specified Amazon Kinesis stream. Each stream
  can have up to 10 tags.

  If tags have already been assigned to the stream, `AddTagsToStream`
  overwrites any existing tags that correspond to the specified tag keys.
  """
  def add_tags_to_stream(client, input, options \\ []) do
    request(client, "AddTagsToStream", input, options)
  end

  @doc """
  Creates a Amazon Kinesis stream. A stream captures and transports data
  records that are continuously emitted from different data sources or
  *producers*. Scale-out within an Amazon Kinesis stream is explicitly
  supported by means of shards, which are uniquely identified groups of data
  records in an Amazon Kinesis stream.

  You specify and control the number of shards that a stream is composed of.
  Each shard can support reads up to 5 transactions per second, up to a
  maximum data read total of 2 MB per second. Each shard can support writes
  up to 1,000 records per second, up to a maximum data write total of 1 MB
  per second. You can add shards to a stream if the amount of data input
  increases and you can remove shards if the amount of data input decreases.

  The stream name identifies the stream. The name is scoped to the AWS
  account used by the application. It is also scoped by region. That is, two
  streams in two different accounts can have the same name, and two streams
  in the same account, but in two different regions, can have the same name.

  `CreateStream` is an asynchronous operation. Upon receiving a
  `CreateStream` request, Amazon Kinesis immediately returns and sets the
  stream status to `CREATING`. After the stream is created, Amazon Kinesis
  sets the stream status to `ACTIVE`. You should perform read and write
  operations only on an `ACTIVE` stream.

  You receive a `LimitExceededException` when making a `CreateStream` request
  if you try to do one of the following:

  <ul> <li>Have more than five streams in the `CREATING` state at any point
  in time.</li> <li>Create more shards than are authorized for your
  account.</li> </ul> For the default shard limit for an AWS account, see
  [Amazon Kinesis
  Limits](http://docs.aws.amazon.com/kinesis/latest/dev/service-sizes-and-limits.html).
  If you need to increase this limit, [contact AWS
  Support](http://docs.aws.amazon.com/general/latest/gr/aws_service_limits.html).

  You can use `DescribeStream` to check the stream status, which is returned
  in `StreamStatus`.

  `CreateStream` has a limit of 5 transactions per second per account.
  """
  def create_stream(client, input, options \\ []) do
    request(client, "CreateStream", input, options)
  end

  @doc """
  Decreases the stream's retention period, which is the length of time data
  records are accessible after they are added to the stream. The minimum
  value of a stream’s retention period is 24 hours.

  This operation may result in lost data. For example, if the stream's
  retention period is 48 hours and is decreased to 24 hours, any data already
  in the stream that is older than 24 hours is inaccessible.
  """
  def decrease_stream_retention_period(client, input, options \\ []) do
    request(client, "DecreaseStreamRetentionPeriod", input, options)
  end

  @doc """
  Deletes a stream and all its shards and data. You must shut down any
  applications that are operating on the stream before you delete the stream.
  If an application attempts to operate on a deleted stream, it will receive
  the exception `ResourceNotFoundException`.

  If the stream is in the `ACTIVE` state, you can delete it. After a
  `DeleteStream` request, the specified stream is in the `DELETING` state
  until Amazon Kinesis completes the deletion.

  **Note:** Amazon Kinesis might continue to accept data read and write
  operations, such as `PutRecord`, `PutRecords`, and `GetRecords`, on a
  stream in the `DELETING` state until the stream deletion is complete.

  When you delete a stream, any shards in that stream are also deleted, and
  any tags are dissociated from the stream.

  You can use the `DescribeStream` operation to check the state of the
  stream, which is returned in `StreamStatus`.

  `DeleteStream` has a limit of 5 transactions per second per account.
  """
  def delete_stream(client, input, options \\ []) do
    request(client, "DeleteStream", input, options)
  end

  @doc """
  Describes the specified stream.

  The information about the stream includes its current status, its Amazon
  Resource Name (ARN), and an array of shard objects. For each shard object,
  there is information about the hash key and sequence number ranges that the
  shard spans, and the IDs of any earlier shards that played in a role in
  creating the shard. A sequence number is the identifier associated with
  every record ingested in the Amazon Kinesis stream. The sequence number is
  assigned when a record is put into the stream.

  You can limit the number of returned shards using the `Limit` parameter.
  The number of shards in a stream may be too large to return from a single
  call to `DescribeStream`. You can detect this by using the `HasMoreShards`
  flag in the returned output. `HasMoreShards` is set to `true` when there is
  more data available.

  `DescribeStream` is a paginated operation. If there are more shards
  available, you can request them using the shard ID of the last shard
  returned. Specify this ID in the `ExclusiveStartShardId` parameter in a
  subsequent request to `DescribeStream`.

  `DescribeStream` has a limit of 10 transactions per second per account.
  """
  def describe_stream(client, input, options \\ []) do
    request(client, "DescribeStream", input, options)
  end

  @doc """
  Gets data records from a shard.

  Specify a shard iterator using the `ShardIterator` parameter. The shard
  iterator specifies the position in the shard from which you want to start
  reading data records sequentially. If there are no records available in the
  portion of the shard that the iterator points to, `GetRecords` returns an
  empty list. Note that it might take multiple calls to get to a portion of
  the shard that contains records.

  You can scale by provisioning multiple shards. Your application should have
  one thread per shard, each reading continuously from its stream. To read
  from a stream continually, call `GetRecords` in a loop. Use
  `GetShardIterator` to get the shard iterator to specify in the first
  `GetRecords` call. `GetRecords` returns a new shard iterator in
  `NextShardIterator`. Specify the shard iterator returned in
  `NextShardIterator` in subsequent calls to `GetRecords`. Note that if the
  shard has been closed, the shard iterator can't return more data and
  `GetRecords` returns `null` in `NextShardIterator`. You can terminate the
  loop when the shard is closed, or when the shard iterator reaches the
  record with the sequence number or other attribute that marks it as the
  last record to process.

  Each data record can be up to 1 MB in size, and each shard can read up to 2
  MB per second. You can ensure that your calls don't exceed the maximum
  supported size or throughput by using the `Limit` parameter to specify the
  maximum number of records that `GetRecords` can return. Consider your
  average record size when determining this limit.

  The size of the data returned by `GetRecords` will vary depending on the
  utilization of the shard. The maximum size of data that `GetRecords` can
  return is 10 MB. If a call returns this amount of data, subsequent calls
  made within the next 5 seconds throw
  `ProvisionedThroughputExceededException`. If there is insufficient
  provisioned throughput on the shard, subsequent calls made within the next
  1 second throw `ProvisionedThroughputExceededException`. Note that
  `GetRecords` won't return any data when it throws an exception. For this
  reason, we recommend that you wait one second between calls to
  `GetRecords`; however, it's possible that the application will get
  exceptions for longer than 1 second.

  To detect whether the application is falling behind in processing, you can
  use the `MillisBehindLatest` response attribute. You can also monitor the
  stream using CloudWatch metrics (see [Monitoring Amazon
  Kinesis](http://docs.aws.amazon.com/kinesis/latest/dev/monitoring.html) in
  the *Amazon Kinesis Developer Guide*).

  Each Amazon Kinesis record includes a value, `ApproximateArrivalTimestamp`,
  that is set when an Amazon Kinesis stream successfully receives and stores
  a record. This is commonly referred to as a server-side timestamp, which is
  different than a client-side timestamp, where the timestamp is set when a
  data producer creates or sends the record to a stream. The timestamp has
  millisecond precision. There are no guarantees about the timestamp
  accuracy, or that the timestamp is always increasing. For example, records
  in a shard or across a stream might have timestamps that are out of order.
  """
  def get_records(client, input, options \\ []) do
    request(client, "GetRecords", input, options)
  end

  @doc """
  Gets a shard iterator. A shard iterator expires five minutes after it is
  returned to the requester.

  A shard iterator specifies the position in the shard from which to start
  reading data records sequentially. A shard iterator specifies this position
  using the sequence number of a data record in a shard. A sequence number is
  the identifier associated with every record ingested in the Amazon Kinesis
  stream. The sequence number is assigned when a record is put into the
  stream.

  You must specify the shard iterator type. For example, you can set the
  `ShardIteratorType` parameter to read exactly from the position denoted by
  a specific sequence number by using the `AT_SEQUENCE_NUMBER` shard iterator
  type, or right after the sequence number by using the
  `AFTER_SEQUENCE_NUMBER` shard iterator type, using sequence numbers
  returned by earlier calls to `PutRecord`, `PutRecords`, `GetRecords`, or
  `DescribeStream`. You can specify the shard iterator type `TRIM_HORIZON` in
  the request to cause `ShardIterator` to point to the last untrimmed record
  in the shard in the system, which is the oldest data record in the shard.
  Or you can point to just after the most recent record in the shard, by
  using the shard iterator type `LATEST`, so that you always read the most
  recent data in the shard.

  When you repeatedly read from an Amazon Kinesis stream use a
  `GetShardIterator` request to get the first shard iterator for use in your
  first `GetRecords` request and then use the shard iterator returned by the
  `GetRecords` request in `NextShardIterator` for subsequent reads. A new
  shard iterator is returned by every `GetRecords` request in
  `NextShardIterator`, which you use in the `ShardIterator` parameter of the
  next `GetRecords` request.

  If a `GetShardIterator` request is made too often, you receive a
  `ProvisionedThroughputExceededException`. For more information about
  throughput limits, see `GetRecords`.

  If the shard is closed, the iterator can't return more data, and
  `GetShardIterator` returns `null` for its `ShardIterator`. A shard can be
  closed using `SplitShard` or `MergeShards`.

  `GetShardIterator` has a limit of 5 transactions per second per account per
  open shard.
  """
  def get_shard_iterator(client, input, options \\ []) do
    request(client, "GetShardIterator", input, options)
  end

  @doc """
  Increases the stream's retention period, which is the length of time data
  records are accessible after they are added to the stream. The maximum
  value of a stream’s retention period is 168 hours (7 days).

  Upon choosing a longer stream retention period, this operation will
  increase the time period records are accessible that have not yet expired.
  However, it will not make previous data that has expired (older than the
  stream’s previous retention period) accessible after the operation has been
  called. For example, if a stream’s retention period is set to 24 hours and
  is increased to 168 hours, any data that is older than 24 hours will remain
  inaccessible to consumer applications.
  """
  def increase_stream_retention_period(client, input, options \\ []) do
    request(client, "IncreaseStreamRetentionPeriod", input, options)
  end

  @doc """
  Lists your streams.

  The number of streams may be too large to return from a single call to
  `ListStreams`. You can limit the number of returned streams using the
  `Limit` parameter. If you do not specify a value for the `Limit` parameter,
  Amazon Kinesis uses the default limit, which is currently 10.

  You can detect if there are more streams available to list by using the
  `HasMoreStreams` flag from the returned output. If there are more streams
  available, you can request more streams by using the name of the last
  stream returned by the `ListStreams` request in the
  `ExclusiveStartStreamName` parameter in a subsequent request to
  `ListStreams`. The group of stream names returned by the subsequent request
  is then added to the list. You can continue this process until all the
  stream names have been collected in the list.

  `ListStreams` has a limit of 5 transactions per second per account.
  """
  def list_streams(client, input, options \\ []) do
    request(client, "ListStreams", input, options)
  end

  @doc """
  Lists the tags for the specified Amazon Kinesis stream.
  """
  def list_tags_for_stream(client, input, options \\ []) do
    request(client, "ListTagsForStream", input, options)
  end

  @doc """
  Merges two adjacent shards in a stream and combines them into a single
  shard to reduce the stream's capacity to ingest and transport data. Two
  shards are considered adjacent if the union of the hash key ranges for the
  two shards form a contiguous set with no gaps. For example, if you have two
  shards, one with a hash key range of 276...381 and the other with a hash
  key range of 382...454, then you could merge these two shards into a single
  shard that would have a hash key range of 276...454. After the merge, the
  single child shard receives data for all hash key values covered by the two
  parent shards.

  `MergeShards` is called when there is a need to reduce the overall capacity
  of a stream because of excess capacity that is not being used. You must
  specify the shard to be merged and the adjacent shard for a stream. For
  more information about merging shards, see [Merge Two
  Shards](http://docs.aws.amazon.com/kinesis/latest/dev/kinesis-using-sdk-java-resharding-merge.html)
  in the *Amazon Kinesis Developer Guide*.

  If the stream is in the `ACTIVE` state, you can call `MergeShards`. If a
  stream is in the `CREATING`, `UPDATING`, or `DELETING` state, `MergeShards`
  returns a `ResourceInUseException`. If the specified stream does not exist,
  `MergeShards` returns a `ResourceNotFoundException`.

  You can use `DescribeStream` to check the state of the stream, which is
  returned in `StreamStatus`.

  `MergeShards` is an asynchronous operation. Upon receiving a `MergeShards`
  request, Amazon Kinesis immediately returns a response and sets the
  `StreamStatus` to `UPDATING`. After the operation is completed, Amazon
  Kinesis sets the `StreamStatus` to `ACTIVE`. Read and write operations
  continue to work while the stream is in the `UPDATING` state.

  You use `DescribeStream` to determine the shard IDs that are specified in
  the `MergeShards` request.

  If you try to operate on too many streams in parallel using `CreateStream`,
  `DeleteStream`, `MergeShards` or `SplitShard`, you will receive a
  `LimitExceededException`.

  `MergeShards` has limit of 5 transactions per second per account.
  """
  def merge_shards(client, input, options \\ []) do
    request(client, "MergeShards", input, options)
  end

  @doc """
  Writes a single data record from a producer into an Amazon Kinesis stream.
  Call `PutRecord` to send data from the producer into the Amazon Kinesis
  stream for real-time ingestion and subsequent processing, one record at a
  time. Each shard can support writes up to 1,000 records per second, up to a
  maximum data write total of 1 MB per second.

  You must specify the name of the stream that captures, stores, and
  transports the data; a partition key; and the data blob itself.

  The data blob can be any type of data; for example, a segment from a log
  file, geographic/location data, website clickstream data, and so on.

  The partition key is used by Amazon Kinesis to distribute data across
  shards. Amazon Kinesis segregates the data records that belong to a data
  stream into multiple shards, using the partition key associated with each
  data record to determine which shard a given data record belongs to.

  Partition keys are Unicode strings, with a maximum length limit of 256
  characters for each key. An MD5 hash function is used to map partition keys
  to 128-bit integer values and to map associated data records to shards
  using the hash key ranges of the shards. You can override hashing the
  partition key to determine the shard by explicitly specifying a hash value
  using the `ExplicitHashKey` parameter. For more information, see [Adding
  Data to a
  Stream](http://docs.aws.amazon.com/kinesis/latest/dev/developing-producers-with-sdk.html#kinesis-using-sdk-java-add-data-to-stream)
  in the *Amazon Kinesis Developer Guide*.

  `PutRecord` returns the shard ID of where the data record was placed and
  the sequence number that was assigned to the data record.

  Sequence numbers generally increase over time. To guarantee strictly
  increasing ordering, use the `SequenceNumberForOrdering` parameter. For
  more information, see [Adding Data to a
  Stream](http://docs.aws.amazon.com/kinesis/latest/dev/developing-producers-with-sdk.html#kinesis-using-sdk-java-add-data-to-stream)
  in the *Amazon Kinesis Developer Guide*.

  If a `PutRecord` request cannot be processed because of insufficient
  provisioned throughput on the shard involved in the request, `PutRecord`
  throws `ProvisionedThroughputExceededException`.

  By default, data records are accessible for only 24 hours from the time
  that they are added to an Amazon Kinesis stream. This retention period can
  be modified using the `DecreaseStreamRetentionPeriod` and
  `IncreaseStreamRetentionPeriod` operations.
  """
  def put_record(client, input, options \\ []) do
    request(client, "PutRecord", input, options)
  end

  @doc """
  Writes multiple data records from a producer into an Amazon Kinesis stream
  in a single call (also referred to as a `PutRecords` request). Use this
  operation to send data from a data producer into the Amazon Kinesis stream
  for data ingestion and processing.

  Each `PutRecords` request can support up to 500 records. Each record in the
  request can be as large as 1 MB, up to a limit of 5 MB for the entire
  request, including partition keys. Each shard can support writes up to
  1,000 records per second, up to a maximum data write total of 1 MB per
  second.

  You must specify the name of the stream that captures, stores, and
  transports the data; and an array of request `Records`, with each record in
  the array requiring a partition key and data blob. The record size limit
  applies to the total size of the partition key and data blob.

  The data blob can be any type of data; for example, a segment from a log
  file, geographic/location data, website clickstream data, and so on.

  The partition key is used by Amazon Kinesis as input to a hash function
  that maps the partition key and associated data to a specific shard. An MD5
  hash function is used to map partition keys to 128-bit integer values and
  to map associated data records to shards. As a result of this hashing
  mechanism, all data records with the same partition key map to the same
  shard within the stream. For more information, see [Adding Data to a
  Stream](http://docs.aws.amazon.com/kinesis/latest/dev/developing-producers-with-sdk.html#kinesis-using-sdk-java-add-data-to-stream)
  in the *Amazon Kinesis Developer Guide*.

  Each record in the `Records` array may include an optional parameter,
  `ExplicitHashKey`, which overrides the partition key to shard mapping. This
  parameter allows a data producer to determine explicitly the shard where
  the record is stored. For more information, see [Adding Multiple Records
  with
  PutRecords](http://docs.aws.amazon.com/kinesis/latest/dev/developing-producers-with-sdk.html#kinesis-using-sdk-java-putrecords)
  in the *Amazon Kinesis Developer Guide*.

  The `PutRecords` response includes an array of response `Records`. Each
  record in the response array directly correlates with a record in the
  request array using natural ordering, from the top to the bottom of the
  request and response. The response `Records` array always includes the same
  number of records as the request array.

  The response `Records` array includes both successfully and unsuccessfully
  processed records. Amazon Kinesis attempts to process all records in each
  `PutRecords` request. A single record failure does not stop the processing
  of subsequent records.

  A successfully-processed record includes `ShardId` and `SequenceNumber`
  values. The `ShardId` parameter identifies the shard in the stream where
  the record is stored. The `SequenceNumber` parameter is an identifier
  assigned to the put record, unique to all records in the stream.

  An unsuccessfully-processed record includes `ErrorCode` and `ErrorMessage`
  values. `ErrorCode` reflects the type of error and can be one of the
  following values: `ProvisionedThroughputExceededException` or
  `InternalFailure`. `ErrorMessage` provides more detailed information about
  the `ProvisionedThroughputExceededException` exception including the
  account ID, stream name, and shard ID of the record that was throttled. For
  more information about partially successful responses, see [Adding Multiple
  Records with
  PutRecords](http://docs.aws.amazon.com/kinesis/latest/dev/kinesis-using-sdk-java-add-data-to-stream.html#kinesis-using-sdk-java-putrecords)
  in the *Amazon Kinesis Developer Guide*.

  By default, data records are accessible for only 24 hours from the time
  that they are added to an Amazon Kinesis stream. This retention period can
  be modified using the `DecreaseStreamRetentionPeriod` and
  `IncreaseStreamRetentionPeriod` operations.
  """
  def put_records(client, input, options \\ []) do
    request(client, "PutRecords", input, options)
  end

  @doc """
  Deletes tags from the specified Amazon Kinesis stream.

  If you specify a tag that does not exist, it is ignored.
  """
  def remove_tags_from_stream(client, input, options \\ []) do
    request(client, "RemoveTagsFromStream", input, options)
  end

  @doc """
  Splits a shard into two new shards in the stream, to increase the stream's
  capacity to ingest and transport data. `SplitShard` is called when there is
  a need to increase the overall capacity of stream because of an expected
  increase in the volume of data records being ingested.

  You can also use `SplitShard` when a shard appears to be approaching its
  maximum utilization, for example, when the set of producers sending data
  into the specific shard are suddenly sending more than previously
  anticipated. You can also call `SplitShard` to increase stream capacity, so
  that more Amazon Kinesis applications can simultaneously read data from the
  stream for real-time processing.

  You must specify the shard to be split and the new hash key, which is the
  position in the shard where the shard gets split in two. In many cases, the
  new hash key might simply be the average of the beginning and ending hash
  key, but it can be any hash key value in the range being mapped into the
  shard. For more information about splitting shards, see [Split a
  Shard](http://docs.aws.amazon.com/kinesis/latest/dev/kinesis-using-sdk-java-resharding-split.html)
  in the *Amazon Kinesis Developer Guide*.

  You can use `DescribeStream` to determine the shard ID and hash key values
  for the `ShardToSplit` and `NewStartingHashKey` parameters that are
  specified in the `SplitShard` request.

  `SplitShard` is an asynchronous operation. Upon receiving a `SplitShard`
  request, Amazon Kinesis immediately returns a response and sets the stream
  status to `UPDATING`. After the operation is completed, Amazon Kinesis sets
  the stream status to `ACTIVE`. Read and write operations continue to work
  while the stream is in the `UPDATING` state.

  You can use `DescribeStream` to check the status of the stream, which is
  returned in `StreamStatus`. If the stream is in the `ACTIVE` state, you can
  call `SplitShard`. If a stream is in `CREATING` or `UPDATING` or `DELETING`
  states, `DescribeStream` returns a `ResourceInUseException`.

  If the specified stream does not exist, `DescribeStream` returns a
  `ResourceNotFoundException`. If you try to create more shards than are
  authorized for your account, you receive a `LimitExceededException`.

  For the default shard limit for an AWS account, see [Amazon Kinesis
  Limits](http://docs.aws.amazon.com/kinesis/latest/dev/service-sizes-and-limits.html).
  If you need to increase this limit, [contact AWS
  Support](http://docs.aws.amazon.com/general/latest/gr/aws_service_limits.html).

  If you try to operate on too many streams in parallel using `CreateStream`,
  `DeleteStream`, `MergeShards` or `SplitShard`, you receive a
  `LimitExceededException`.

  `SplitShard` has limit of 5 transactions per second per account.
  """
  def split_shard(client, input, options \\ []) do
    request(client, "SplitShard", input, options)
  end

  @spec request(map(), binary(), map(), list()) ::
    {:ok, Poison.Parser.t | nil, Poison.Response.t} |
    {:error, Poison.Parser.t} |
    {:error, HTTPoison.Error.t}
  defp request(client, action, input, options) do
    client = %{client | service: "kinesis"}
    host = get_host("kinesis", client)
    url = get_url(host, client)
    headers = [{"Host", host},
               {"Content-Type", "application/x-amz-json-1.1"},
               {"X-Amz-Target", "Kinesis_20131202.#{action}"}]
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
