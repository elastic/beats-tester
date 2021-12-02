# The Beats Tester

Vagrant + Ansible setup for testing the OS packages and basic e2e tests for all
the [Beats](https://www.elastic.co/products/beats).

## OS matrix

  OS | Support
---- | -------
awslinux | :white_check_mark:
awslinux2 | :white_check_mark:
centos7-64 | :white_check_mark:
centos8-64 | :white_check_mark:
debian10-64 | :white_check_mark:
debian8-64 | :white_check_mark:
debian9-64 | :white_check_mark:
sles12-64 | :white_check_mark:
ubuntu1804-64 | :white_check_mark:
ubuntu2004-64 | :white_check_mark:
win12-64 | :white_check_mark:

It's possible to run this test suite for all the OSs in the support matrix above, or for a subset of those OSs. The possible use cases are:

- test all Beats for all OSs
- test all Beats for only one OS
- test one Beat for all OSs
- test one Beat for only one OS
- test all Beats in batches for all OSs
- test all Beats in batches for one group of OSs

> The supported groups are 'centos', 'debian', 'sles' and 'windows'.

## Preparing the machines

### For all OSs

You need to bring all the machines up:

```shell
make setup
```

> If the command fails with the following error, please retry `make setup` again:

```
The following SSH command responded with a non-zero exit status.
Vagrant assumes that this means the command failed!

umount /mnt

Stdout from the command:



Stderr from the command:

umount: /mnt: not mounted
```

### For one OS

Only a particular OS will be spun by Vagrant. In the following example, we are going to provision a Debian 8 amd64 image:

```shell
MACHINE=tester-debian8-64 make setup
```

> You will find the machine types in the [Vagrantfile](./Vagrantfile), under the `config.vm.define` attribute. The name convention uses `tester-` as prefix of the OS listed in the above support matrix.

## Running the tests

Once the target machines are ready, you need Ansible to run the tests. Because they could involve lots of VMs and commands executed over SSH, these tests are slow (currently 15 minutes in total).

The commands that are available for running the tests are:

- `make run`: it will run the tests for all the OSs in the support matrix.
- `make run-group`: it will run the tests for all the OSs in a group of OSs. For each ansible group, it will start the vm, check the VM's status, configure SSH, run the ansible playbook, and finally will destroy the vm.
- `make batch`: it will run the tests in batches. Since it processes each group sequentially, it uses less CPU and memory.

It's possible to define what versions of the binaries are used in the tests, you must simply declare the `RUN_SETTINGS` environment variable with the following values: `nightlies`, `released`, `snapshot` and `staging`. These values come from the `run-settings-*.yml` files located at the root directory of this project, where specific variables are configured for the Ansible execution. The default value for this variable is `nightlies`.

Besides that, it's also possible to run the tests for one particular Beat. You simply need to pass the `ANSIBLE_EXTRA_FLAGS="--tags THE_BEAT"` environment variable to the command execution, so that Ansible is able to filter the tasks to be run for that Beat.

### Execution examples

Here are some execution examples:

* Test the nightly builds from Beats CI. If the `RUN_SETTINGS` variable is omitted, it will be used as default value:

```shell
make run
#or
RUN_SETTINGS=nightlies make run
```

* Test the [most recent snapshots from the Unified Release Manager](https://internal-ci.elastic.co/job/elastic+release-manager+master+unified-snapshot/) (excluding OS X):

```shell
RUN_SETTINGS=snapshot make run
```

* All tests, all platforms, a particular release. You must update the value of the `version` in the `run-settings-released.yml` file:

```shell
RUN_SETTINGS=released make run
```

* Only a particular Beat, Packetbeat in the example:

```shell
export ANSIBLE_EXTRA_FLAGS="--tags packetbeat"
make run
```

* Only a particular OS, Debian 8 amd64 in the example:

Given you used 'make setup' for one single machine:

```shell
MACHINE=tester-debian8-64
make run-machine
```

* All ansible groups in batches:

```shell
# Run tests in batches for all hosts
make batch
```

* Only a set of ansible groups in batches:

```shell
# Run tests in batchesfor all Linux hosts:
GROUPS="centos debian sles" make batch
# Run tests in batches for all Debian hosts:
GROUPS=debian make batch
# Run tests in batches for Windows hosts
GROUPS=windows make batch
```

### Other useful executions

* Enable Ansible debug.

```shell
export ANSIBLE_VERBOSE="-vvv"
make run
```

* Executing tests on your local macOS machine. In System Preferences -> Sharing
  enable _Remote Login_ (SSH). Don't forget to disable _Remote Login_ when you
  are done.

```shell
export ANSIBLE_EXTRA_FLAGS="--ask-sudo-pass"
export ANSIBLE_LIMIT="localhost"
make run
```

* Run just the APM Server tests:

```shell
export ANSIBLE_EXTRA_FLAGS="--tags apm-server"
make run
```

## Cleanup

You need to tear down the VMs when you are finished.

    make clean
