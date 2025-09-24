import { setupManifest } from '@start9labs/start-sdk'
import { SDKImageInputSpec } from '@start9labs/start-sdk/base/lib/types/ManifestTypes'

const BUILD = process.env.BUILD || ''

const architectures =
  BUILD === 'x86_64' || BUILD === 'aarch64' ? [BUILD] : ['x86_64', 'aarch64']

export const manifest = setupManifest({
  id: 'ollama',
  title: 'Ollama & Open WebUI',
  license: 'MIT',
  wrapperRepo: 'https://github.com/Start9Labs/freegpt2-startos',
  upstreamRepo: 'https://github.com/Start9Labs/freegpt2-startos',
  supportSite: 'https://github.com/Start9Labs/freegpt2-startos/issues',
  marketingSite: 'https://start9.com/',
  donationUrl: null,
  docsUrl: 'https://github.com/Start9Labs/freegpt2-startos/blob/update/040/docs/README.md',
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
      arch: architectures
    } as SDKImageInputSpec,
  },
  // @TODO
  hardwareRequirements: { arch: architectures },
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
