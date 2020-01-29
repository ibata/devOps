# Deleting old indices in Elasticsearch using Curator

## Use case: disk usage exceptions
Elasticsearch can throw disk usage exceptions like these:
```
[INFO ][cluster.allocation] [NodeB] low disk usage [90%] exceeded on [ NodeA] free: 5gb[10%], replicas will not be assigned to this node
[WARN ][cluster.allocation] [NodeA] high disk usage [95%] exceeded on [ myELK -Node2] free: 4.8gb[9.9%], shards will be relocated away from this node
[INFO ][cluster.allocation] [NodeA] high disk usage exceeded on one or more nodes, rerouting shards....
```

This can cause a drastic performance reduction of the Elasticsearch service, and finally lead to its crash.

## Root Cause
A huge number of logs can be written to the Elasticsearch service periodically. If you don't have a proper archival process in place, data in the Elasticsearch cluster will grow uncontrollably, which can lead to the loss of valuable log data if you don't provide enough disk space.

## Solution
Curator is a tool from Elastic (the company behind Elasticsearch) to help manage your Elasticsearch cluster. Curator is a Python-based tool that can help you manage Elasticsearch indices. Deleting old indices is one of the primary use cases for Curator.

As a prerequisite, you must install Python version 3.4+. You can then install Curator using the following pip command:
- Your jenkins job > Build > Add build step > Execute shell > Command:
```
#!/bin/bash
pip install --user elasticsearch-curator
```

## Remove old indices with YAML-based Curator configuration

```
curator [--config CONFIG.YML] ACTION_FILE.YML --dry-run
```
The --dry-run mode will not actually impact the index. It can be used to test the output of the action.
- Your jenkins job > Build > Add build step > Execute shell > Command:
```
#!/bin/bash
pip install --user elasticsearch-curator
/d1/jenkins/.local/bin/curator --config config.yml action-delete.yml
```
- Your jenkins job > Source Code Management > Git > Repositories > 
```
Repository URL : git@github.xxxx
Credentials    : xxxx
```
- Your jenkins job > Source Code Management > Git > branches to build > 
```
Branch Specifier (blank for 'any')	: ${GIT_REVISION}
```
- Your YAML-based Curator configuration on Github > [config.yml](https://xxxx.github.xxxx/lc-elasticsearch-reindexing/blob/master/config.yml) AND [action-delete.yml](https://xxx.github.xxx/lc-elasticsearch-reindexing/blob/master/action-delete.yml)

- Jenkins job output (sample)
```
2018–02–05 11:30:35,075 INFO      Preparing Action ID: 1, "delete_indices"
2018–02–05 11:30:35,095 INFO      Trying Action ID: 1, "delete_indices": Delete indices older than 30 days (based on index name), for logstash- prefixed indices. Ignore the error if the filter does not result in an actionable list of indices (ignore_empty_list) and exit cleanly.
2018–02–05 11:30:35,095 INFO      DRY-RUN MODE.  No changes will be made.
2018–02–05 11:30:35,095 INFO      (CLOSED) indices may be shown that may not be acted on by action "delete_indices".
2018–02–05 11:30:35,095 INFO      Action ID: 1, "delete_indices" completed.
2018–02–05 11:30:35,095 INFO      Job completed.
```
