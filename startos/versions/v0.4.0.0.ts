import { VersionInfo, IMPOSSIBLE } from '@start9labs/start-sdk'
import { sdk } from '../sdk'
import { setName } from '../actions/setName'

export const v_0_4_0_0 = VersionInfo.of({
  version: '0.4.0:0',
  releaseNotes: 'Revamped for StartOS 0.4.0',
  migrations: {
    up: async ({ effects }) => {
      await sdk.action.requestOwn(effects, setName, 'critical', {
        reason: 'Needed because how else would people know?',
      })
    },
    down: IMPOSSIBLE,
  },
})
