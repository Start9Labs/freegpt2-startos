import { types as T, healthUtil } from "../deps.ts";

export const health: T.ExpectedExports.health = {
  "web-ui": healthUtil.checkWebUrl("http://ollama.embassy:8080")
}