const Loader = require('componentsjs').Loader;

const loader = new Loader();
const myServer = await loader.instantiate('http://example.org/config.ttl#myServer');
