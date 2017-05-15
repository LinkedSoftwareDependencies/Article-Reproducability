const loader = new require('lsd-components').Loader();
loader.registerConfig('http://example.org/my-ldf-server');
let myParser = loader.instantiate('http://example.org/config-ldf#myServer');
