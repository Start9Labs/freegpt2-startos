import { sdk } from './sdk'
import { T } from '@start9labs/start-sdk'
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
      .addVolume('main', null, '/app/backend/data', false)
      .addVolume('ollama', null, '/root', false)
      // @TODO do we need this cert volume?
      .addVolume('cert', null, '/mnt/cert', false),
    'ollama-sub',
  )

  /**
   * ======================== Additional Health Checks (optional) ========================
   */
  const additionalChecks: T.HealthCheck[] = []

  /**
   * ======================== Daemons ========================
   */
  return sdk.Daemons.of(effects, started, additionalChecks)
    .addDaemon('ollama', {
      subcontainer: ollamaSub,
      command: ['ollama', 'serve'],
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
      command: ['exec', '/app/backend/start.sh'],
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
