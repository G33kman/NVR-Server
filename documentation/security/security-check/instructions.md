# Docker Bench for Security
The Docker Bench for Security is a script that checks for dozens of common best-practices around deploying Docker containers in production.

<div align="right">
> [!NOTE]
> The tests are all automated, and are based on the CIS Docker Benchmark v1.6.0.
</div>

---
<div align="center">
  <img src="/documentation/assets/images/gui/bench-security/UI-log.png" alt="Bench-Security Log output example image" width="auto" height="80%">
</div>

<div align="right">
> [!NOTE]
> (GitHub Repository Link)[https://github.com/docker/docker-bench-security]
</div>

---
## RUNNING DOCKER BENCH FOR SECUIRTY
Steps for running the Bench Security Audit

### Run from your base host
You can simply run this script from your base host by running:

```sh
git clone https://github.com/docker/docker-bench-security.git
cd docker-bench-security
sudo sh docker-bench-security.sh
```

<div align="right">
> [!NOTE]
> [`jq`](https://jqlang.github.io/jq/) is an optional but recommended dependency
</div>

### Run with Docker
You have two options if you wish to build and run this container yourself:

---
1. Use Docker Build

```sh
git clone https://github.com/docker/docker-bench-security.git
cd docker-bench-security
docker build --no-cache -t docker-bench-security .
```

Followed by an appropriate `docker run` command as stated below.

---
2. Use Docker Compose:

```sh
git clone https://github.com/docker/docker-bench-security.git
cd docker-bench-security
docker compose run --rm docker-bench-security
```

_Please note that the `docker/docker-bench-security` image is out of date[^1] and a manual build is **required**._

[^1]: See [#405](https://github.com/docker/docker-bench-security/issues/405) for more information

> [!NOTE]
> This container is being run with a *lot* of privileges -- sharing the host's filesystem, pid and netowkr namespaces, due to portions of the benchmark applying to the running host.

---
### Using the container


```sh
docker run --rm --net host --pid host --userns host --cap-add audit-control \
-e DOCKER_CONTENT_TRUST=$DOCKER_CONTENT_TRUST \
-v /etc:/etc:ro \
-v /usr/bin/containerd:/usr/bin/containerd:ro \
-v /usr/bin/runc:/usr/bin/runc:ro \
-v /usr/lib/systemd:/usr/lib/systemd:ro \
-v /var/lib:/var/lib:ro \
-v /var/run/docker.sock:/var/run/docker.sock:ro \
--label docker_bench_security \
docker-bench-security
```

<div align="right">
> [!NOTE]
> Don't forget to adjust the shared volumes according to the operating system.
</div>

---
<div align="right">
> [!IMPORTANT]
> On Ubuntu the `docker.service` and `docker.secret` (if applicable) files are located in `/lib/sysstemd/system` folder by default
</div>

```sh
docker run -rm --net host --pid host --userns host --cap-add audit_control \
-e DOCKER_CONTENT_TRUST=$DOCKER_CONTENT_TRUST \
-v /etc:/etc:ro \
-v /lib/systemd/system:/lib/systemd/system:ro \
-v /usr/bin/containerd:/usr/bin/containerd:ro \
-v /usr/bin/runc:/usr/bin/runc:ro \
-v /usr/lib/systemd:/usr/lib/systemd:ro \
-v /var/lib:/var/lib:ro \
-v /var/run/docker.sock:/var/run/docker.sock:ro \
--label docker_bench_security \
docker-bench-security
```

<div align="right">
> [!NOTE]
> When the distribution doesn't contain `auditctl`, the audit test will check `/etc/audit/audit.rules` to see if a rule is present instead.
</div>

### Docker Bench for Security Options
Option | Requirement | Description | Example |
:---:|:---:|:---:|:---:|
-b|Optional|Do not print colors|None
-h|Optional|Print this *help* message|None
-l|Optional|Log output in a *FILE*, inside contianer if run using docker.|`-l FILE`
-u|Optional|Comma delimited list of trusted docker user(s).|`-u USERS`
-t|Optional|Comma delimited list of specific check(s) id|`-c CHECK`
-e|Optional|Comma delimited list of specific check(s) id to exclude|`-e CHECK`
-i|Optional|Comma delimited list of patterns within a container or image name to check|`-i INCLUDE`
-x|Optional|Comma delimited list of patterns within a container or image name to exclude from check|`-x EXCLUDE`
-t|Optional|Comma delimited list of labels within a container or image to check|`-t LABLE`
-n|Optional|In JSON  output, when reporting lists of items (containers, images, etc.), limit the number of reported items to `LIMIT`, Default *0* (no limit).|`-n LIMIT`
-p|Optional|Disable the printing of remediation measures. Default: print remediation measures.|`-p PRINT`

By default the Docker Bench for Security script will run all available CIS tests and produce
logs in the log folder from current directory, named `docker-bench-security.log.json` and
`docker-bench-security.log`.

If the docker container is used then the log files will be created inside the container in location `/usr/local/bin/log/`. If you wish to access them from the host after the container has been run you will need to mount a volume for storing them in.

The CIS based checks are named `check_<section>_<number>`, e.g. `check_2_6` and community contributed checks are named `check_c_<number>`.

`sh docker-bench-security.sh -c check_2_2` will only run check `2.2 Ensure the logging level is set to 'info'`.

`sh docker-bench-security.sh -e check_2_2` will run all available checks except `2.2 Ensure the logging level is set to 'info'`.

`sh docker-bench-security.sh -e docker_enterprise_configuration` will run all available checks except the docker_enterprise_configuration group

`sh docker-bench-security.sh -e docker_enterprise_configuration,check_2_2` will run all available checks except the docker_enterprise_configuration group and `2.2 Ensure the logging level is set to 'info'`

`sh docker-bench-security.sh -c container_images,container_runtime` will run just the container_images and container_runtime checks

`sh docker-bench-security.sh -c container_images -e check_4_5` will run just the container_images checks except `4.5 Ensure Content trust for Docker is Enabled`

Note that when submitting checks, provide information why it is a reasonable test to add and please include some kind of official documentation verifying that information.
