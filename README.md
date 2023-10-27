
### About Shoreline
The Shoreline platform provides real-time monitoring, alerting, and incident automation for cloud operations. Use Shoreline to detect, debug, and automate repairs across your entire fleet in seconds with just a few lines of code.

Shoreline Agents are efficient and non-intrusive processes running in the background of all your monitored hosts. Agents act as the secure link between Shoreline and your environment's Resources, providing real-time monitoring and metric collection across your fleet. Agents can execute actions on your behalf -- everything from simple Linux commands to full remediation playbooks -- running simultaneously across all the targeted Resources.

Since Agents are distributed throughout your fleet and monitor your Resources in real time, when an issue occurs Shoreline automatically alerts your team before your operators notice something is wrong. Plus, when you're ready for it, Shoreline can automatically resolve these issues using Alarms, Actions, Bots, and other Shoreline tools that you configure. These objects work in tandem to monitor your fleet and dispatch the appropriate response if something goes wrong -- you can even receive notifications via the fully-customizable Slack integration.

Shoreline Notebooks let you convert your static runbooks into interactive, annotated, sharable web-based documents. Through a combination of Markdown-based notes and Shoreline's expressive Op language, you have one-click access to real-time, per-second debug data and powerful, fleetwide repair commands.

### What are Shoreline Op Packs?
Shoreline Op Packs are open-source collections of Terraform configurations and supporting scripts that use the Shoreline Terraform Provider and the Shoreline Platform to create turnkey incident automations for common operational issues. Each Op Pack comes with smart defaults and works out of the box with minimal setup, while also providing you and your team with the flexibility to customize, automate, codify, and commit your own Op Pack configurations.

# Elasticsearch Shard Allocation Failures
---

Elasticsearch shard allocation failures occur when Elasticsearch nodes are unable to allocate shards to the appropriate nodes in a cluster. This can happen when there are too many shards to allocate or when nodes are not properly configured. When shard allocation fails, it can lead to data loss, search performance issues, and other problems. It is important to monitor Elasticsearch clusters and address any shard allocation failures as soon as possible to maintain the integrity and performance of the cluster.

### Parameters
```shell
export ELASTICSEARCH_ENDPOINT="PLACEHOLDER"

export ELASTICSEARCH_LOG_PATH="PLACEHOLDER"

export ELASTICSEARCH_DATA_PATH="PLACEHOLDER"

export ELASTICSEARCH_CONFIG_PATH="PLACEHOLDER"

export CLUSTER_NAME="PLACEHOLDER"

export INDEX_NAME="PLACEHOLDER"
```

## Debug

### Check Elasticsearch cluster health
```shell
curl -X GET ${ELASTICSEARCH_ENDPOINT}/_cluster/health
```

### Check Elasticsearch node status
```shell
curl -X GET ${ELASTICSEARCH_ENDPOINT}/_cat/nodes
```

### Check Elasticsearch shard allocation
```shell
curl -X GET ${ELASTICSEARCH_ENDPOINT}/_cat/allocation
```

### Check Elasticsearch shard status
```shell
curl -X GET ${ELASTICSEARCH_ENDPOINT}/_cat/shards
```

### Check Elasticsearch logs for errors and warnings
```shell
sudo grep -iE 'error|warn' ${ELASTICSEARCH_LOG_PATH}
```

### Check Elasticsearch disk usage
```shell
df -h | grep ${ELASTICSEARCH_DATA_PATH}
```

### Check Elasticsearch configuration
```shell
cat ${ELASTICSEARCH_CONFIG_PATH}/elasticsearch.yml
```

## Repair

### Review the shard allocation settings and tune them appropriately.
```shell


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


```