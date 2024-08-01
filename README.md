## Docker stuff
### Build
There are two args: 
- `TAGS`: specify ansible tags (default: `shell,gitconfig_school`)
- `WITH_MAN`: specify if docker needs to be unminimized so `man` pages are available (default: `false`)

```bash
docker build -t tomoviktor_ansible .
docker build -t tomoviktor_ansible . --build-arg TAGS="shell" --build-arg WITH_MAN=true
```

### Run
When the docker image is ran `ansible-playbook` will automatically execute. Note that this only runs once, because a `/home/awakefox/playbook_run_flag` file is created and checked.

```bash
docker run --rm -it tomoviktor_ansible
```

### Interact
Just execute `/bin/zsh` on the container.

```bash
docker ps
docker exec -it XXXX /bin/zsh
```
