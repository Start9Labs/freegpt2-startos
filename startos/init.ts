import { sdk } from './sdk'
import { exposedStore, initStore } from './store'
import { setDependencies } from './dependencies'
import { setInterfaces } from './interfaces'
import { versions } from './versions'
import { actions } from './actions'
import { getSecretPhrase } from './utils'
import { yamlFile } from './file-models/config.yml'

// **** PreInstall ****
const preInstall = sdk.setupPreInstall(async ({ effects }) => {
  const name = 'World'

  await yamlFile.write(effects, { name })
})

// **** PostInstall ****
const postInstall = sdk.setupPostInstall(async ({ effects }) => {
  const { name } = (await yamlFile.read.const(effects))!
  await sdk.store.setOwn(
    effects,
    sdk.StorePath.secretPhrase,
    getSecretPhrase(name!),
  )
})

// **** Uninstall ****
const uninstall = sdk.setupUninstall(async ({ effects }) => {})

/**
 * Plumbing. DO NOT EDIT.
 */
export const { packageInit, packageUninit, containerInit } = sdk.setupInit(
  versions,
  preInstall,
  postInstall,
  uninstall,
  setInterfaces,
  setDependencies,
  actions,
  initStore,
  exposedStore,
)
