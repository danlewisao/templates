# Architecture Documentation

In order to get the best experience with the Architecture as Code tooling, we recommend installing the following 

- Docker/[Docker Desktop](https://www.docker.com/products/docker-desktop/)
- [WSL Ubuntu](https://docs.microsoft.com/en-us/windows/wsl/install-manual) or other *nix environment capable of running bash scripts
- [Azure CLI tools](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)
- [Visual Studio Code](https://code.visualstudio.com/Download)

## Generating documents from the markdown files

1. Make sure you are logged into the Azure Container Registry: `$ az acr login --name aoitcr`

2. Run `$ ./build-arch-docs.sh` to run the markdown files through the Markdown Pre-processor Docker image. Output will
   be stored in the `generated` folder.

## Guidance

Full documentation on the architecture as code templates can be found on the AD&E documentation site: