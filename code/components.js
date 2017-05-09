const Loader = require('lsd-components').Loader;
let loader = new Loader();
loader.registerModuleResourcesUrl(
    'http://example.org/module-n3.ttl')
    .then(() =>loader.instantiateFromUrl(
        'http://example.org/config-n3.ttl#myParser',
        'http://example.org/config-n3.ttl'))
    .then((parser) => { ... });