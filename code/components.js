const loader = new require('lsd-components').Loader();
loader.registerModule('http://example.org/module-n3');
loader.registerConfig('http://example.org/config-n3');
let myParser = loader.instantiate('http://example.org/config-n3#myParser');