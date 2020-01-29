# Create daly indices in Elasticsearch using Curator

## Use case: Optimal search and low resource usage

```
To achieve high ingest rates, you want to spread the shards from your active index over as many nodes as possible.
```

## Root Cause
```
Shards are so big that they become unwieldy.
Active index is going to become too big or too old.
```

## Solution
Curator is a tool from Elastic (the company behind Elasticsearch) to help manage your Elasticsearch cluster. Curator is a Python-based tool that can help you manage Elasticsearch indices. Deleting old indices is one of the primary use cases for Curator.

As a prerequisite, you must install Python version 3.4+. You can then install Curator using the following pip command:
- Your jenkins job > Build > Add build step > Execute shell > Command:
```
#!/bin/bash
pip install --user elasticsearch-curator
```

## Create daily indices with YAML-based Curator configuration

```
curator [--config CONFIG.YML] ACTION_FILE.YML --dry-run
```
The --dry-run mode will not actually impact the index. It can be used to test the output of the action.
- Your jenkins job > Build > Add build step > Execute shell > Command:
```
#!/bin/bash
pip install --user elasticsearch-curator
/d1/jenkins/.local/bin/curator --config config.yml action-create-daily-indices.yml
```
- Your jenkins job > Source Code Management > Git > Repositories > 
```
Repository URL : git@github.xxx:OPS/lc-elasticsearch-reindexing.git 
Credentials    : xxx
```
- Your jenkins job > Build Triggers > Build periodically > Schedule > (midnight)
```
0 0 * * *
```

- Your jenkins job > Source Code Management > Git > branches to build > 
```
Branch Specifier (blank for 'any')	: ${GIT_REVISION}
```
- Your YAML-based Curator configuration on Github > [config.yml](https://github/lc-elasticsearch-reindexing/blob/master/config.yml) AND [action-create-daily-indices.yml](https://github/lc-elasticsearch-reindexing/blob/CLD-997/action-create-daily-indices.yml)

- Jenkins job output (sample)
```
2018–02–05 11:30:35,075 INFO      ?????

```

