const loader = new require('lsd-components').Loader();
loader.registerModuleResourcesUrl('http://example.org/module-n3.ttl')
loader.registerConfigUrl('http://example.org/config-n3.ttl')
var myParser = loader.instantiate('http://example.org/config-n3.ttl#myParser');