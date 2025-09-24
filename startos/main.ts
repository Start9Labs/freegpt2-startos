import { sdk } from './sdk'
import { uiPort } from './utils'

export const main = sdk.setupMain(async ({ effects, started }) => {
  /**
   * ======================== Setup (optional) ========================
   */
  console.info('Starting Ollama!')

  const ollamaSub = await sdk.SubContainer.of(
    effects,
    { imageId: 'ollama' },
    sdk.Mounts.of()
      .mountVolume({
        volumeId: 'main',
        subpath: null,
        mountpoint: '/app/backend/data',
        readonly: false,
      })
      .mountVolume({
        volumeId: 'ollama',
        subpath: null,
        mountpoint: '/root',
        readonly: false,
      })
      // @TODO do we need this cert volume?
      .mountVolume({
        volumeId: 'cert',
        subpath: null,
        mountpoint: '/mnt/cert',
        readonly: false,
      }),
    'ollama-sub',
  )

  /**
   * ======================== Daemons ========================
   */
  return sdk.Daemons.of(effects, started)
    .addDaemon('ollama', {
      subcontainer: ollamaSub,
      exec: { command: ['ollama', 'serve'] },
      ready: {
        display: null,
        // @TODO should these be one daemon? Or what is the health check here if not pinging the uiPort?
        fn: () => ({
          result: 'success',
          message: '',
        }),
      },
      requires: [],
    })
    .addDaemon('openwebui', {
      subcontainer: ollamaSub,
      exec: { command: ['exec', '/app/backend/start.sh'] },
      ready: {
        display: 'Web Interface',
        fn: () =>
          sdk.healthCheck.checkPortListening(effects, uiPort, {
            successMessage: 'The web interface is ready',
            errorMessage: 'The web interface is not ready',
          }),
      },
      requires: [],
    })
})
