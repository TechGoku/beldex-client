const WABridge = require('./WABridge')

module.exports = async function () {
  const thisModule = await require('./BeldexClient_WASM.js')({})
  return new WABridge(thisModule)
}
