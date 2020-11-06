# Hypertrace Agents versioning and publishing

This document describes versioning and publishing requirements for Hypertrace agents.
All Hypertrace agents follow these requirements:

* Semantic versioning for all released artifacts.
* Release every merge commit into the main or maintenance branch as `"snapshot"`.
* Maintenance branches for older versions should be named as `release-<major>.<minor>` e.g. `release-1.0`.

#### Semantic versioning

Each released version strictly follows [semantic versioning](https://semver.org/).
The released version must be tagged in the source code: e.g. `1.0.0` or `v1.0.0` for languages
with this convention (e.g. Golang).

#### Snapshot release for every merge commit

Each commit merged into the `main` or maintenance branch (e.g. `release-1.1` for `1.1.x`) should be
published. The version of this release must include commit `SHA` and should include the last released
semantic version and `snapshot` string to denote that the release should not be used in production environment.
The last released semantic version helps to understand which version a given artifact is based on.
The snapshot releases are not tagged in the source control and have no maintenance period.

An example of the version:
* `1.0.1-2a0d8cc26018b09763f5b1dcdf925b6f46ea1882`.
* `1.0.1-SNAPSHOT-2a0d8cc26018b09763f5b1dcdf925b6f46ea1882`.

##### Java

The snapshot releases should not be published to the main
[Hypertrace Bintray organization](https://bintray.com/hypertrace/maven). 
The main Hypertrace organization should contain only semver releases.

TBD create `hypertrace-dev` Bintray organization for snapshot releases.

##### Golang

Since the Golang Modules can depends on `SHA` version there is no need to publish the snapshot release separately.

##### Node.js

TBD

##### Python 

TBD

##### Ruby

TBD

##### C#

TBD

#### Maintenance branches

Maintenance branches contain bug fixes and backported features. The maintenance branch is only
created on demand: for instance when a bug fix has to be applied to an older version and the `main` branch
contains newer versions.

The maintenance branches are created for minor versions e.g. `release-1.0`.
