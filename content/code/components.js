const Loader = require('componentsjs').Loader;

const loader = new Loader();
await loader.registerModuleResourcesUrl('http://example.org/my-ldf-server.ttl');
const myServer = await loader.instantiateFromUrl(
    'http://example.org/myServer', 'http://example.org/config-ldf.ttl');