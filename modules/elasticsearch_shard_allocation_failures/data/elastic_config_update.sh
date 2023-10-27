

#!/bin/bash



# Set the Elasticsearch cluster name and index name

CLUSTER_NAME=${CLUSTER_NAME}

INDEX_NAME=${INDEX_NAME}



# Review current shard allocation settings

curl -XGET "localhost:9200/_cluster/settings?pretty"



# Update the number of shards per index

curl -XPUT "localhost:9200/$INDEX_NAME/_settings" -d '{"index" : {"number_of_shards" : 5}}'



# Update the shard size limit

curl -XPUT "localhost:9200/_cluster/settings" -d '{"persistent" : {"cluster.routing.allocation.disk.watermark.low" : "85%", "cluster.routing.allocation.disk.watermark.high" : "90%"}}'