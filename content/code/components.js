const loader = new require('lsd-components').Loader();
loader.registerModule('http://example.org/module-ldf');
loader.registerConfig('http://example.org/config-ldf');
let myParser = loader.instantiate('http://example.org/config-ldf#myServer');