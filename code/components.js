new require('lsd-components').Loader()
    .registerModuleResourcesUrl('http://example.org/module-n3.ttl')
    .then(() =>loader.instantiateFromUrl(
        'http://example.org/config-n3.ttl#myParser', 'http://example.org/config-n3.ttl'))
    .then((parser) => { ... });