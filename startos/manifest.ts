import { setupManifest } from '@start9labs/start-sdk'

export const manifest = setupManifest({
  id: 'ollama',
  title: 'Ollama & Open WebUI',
  license: 'mit',
  wrapperRepo: 'https://github.com/Start9Labs/freegpt2-startos',
  upstreamRepo: 'https://github.com/Start9Labs/freegpt2-startos',
  supportSite: 'https://github.com/Start9Labs/freegpt2Startos/issues',
  marketingSite: 'https://start9.com/',
  donationUrl: null,
  description: {
    short: 'Person, private AI.',
    long: 'This service combines Ollama for running large language models (LLMs) on your server, and Open WebUI for interacting with them remotely through any browser. This combination provides a clean and intuitive experience for working with locally hosted language models in a sovereign fashion.',
  },
  // @TODO do we need this cert volume?
  volumes: ['main', 'ollama', 'cert'],
  images: {
    ollama: {
      source: {
        dockerBuild: {},
      },
    },
  },
  // @TODO
  hardwareRequirements: {},
  alerts: {
    install: null,
    update: null,
    uninstall: null,
    restore: null,
    start: null,
    stop: null,
  },
  dependencies: {},
})
