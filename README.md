<p align="center">
  <img src="icon.png" alt="Project Logo" width="21%">
</p>

# FreeGPT-2 for StartOS

FreeGPT-2 is born from the merger of two powerful software: [Ollama](https://github.com/ollama/ollama) and [Open Web UI](https://github.com/open-webui/open-webui). Ollama, known for running large language models locally in CLI, is paired with the user-friendly interface of Open WebUI. This combination provides a clean and intuitive experience, making it an invaluable tool for working with locally hosted language models in a sovereign fashion. This repository creates the `s9pk` package that is installed to run FreeGPT-2 on [StartOS](https://github.com/Start9Labs/start-os/). We gratefully acknowledge the use of code from both Ollama and Open WebUI, which has made the creation of FreeGPT-2 possible.

## Dependencies

Prior to building the `freegpt2` package, it's essential to configure your build environment for StartOS services. You can find instructions on how to set up the appropriate build environment in the [Developer Docs](https://docs.start9.com/latest/developer-docs/packaging).

- [docker](https://docs.docker.com/get-docker)
- [docker-buildx](https://docs.docker.com/buildx/working-with-buildx/)
- [deno](https://deno.land/)
- [make](https://www.gnu.org/software/make/)
- [start-sdk](https://github.com/Start9Labs/start-os/tree/sdk/core)
- [yq](https://mikefarah.gitbook.io/yq)

## Cloning

Clone the Ollama package repository locally.

```
git clone https://github.com/Start9Labs/freegpt2-startos.git
cd freegpt2-startos
```

## Building

To build the **Ollama** service as a universal package, run the following command:

```
make
```

Alternatively the package can be built for individual architectures by specifying the architecture as follows:

```
# for amd64
make x86
```
or
```
# for arm64
make arm
```

## Installing (on StartOS)

Before installation, define `host: https://server-name.local` in your `~/.embassy/config.yaml` config file then run the following commands to determine successful install:

> :information_source: Change server-name.local to your Start9 server address

```
start-cli auth login
#Enter your StartOS password
make install
```

**Tip:** You can also install the `freegpt2.s9pk` by sideloading it under the **StartOS > System > Sideload a Service** section.

## Verify Install

Go to your StartOS Services page, select **Ollama** and start the service.

**Done!**