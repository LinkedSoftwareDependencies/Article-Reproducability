## Build
```
bundle install
bundle exec nanoc compile
```

## Development mode
```
bundle install
bundle exec guard
```

## Paper structure
```
introduction
related work
    scholarly + reproducibility
    existing ontologies
    dependency injection

overview
    spec                    sparql
    impl                    ldf server impl
    config                  dep inj config
    experiment              benchmark + input params
    resultaten              output values
    paper                   pdf/html
    -> volgorde: paper -> spec
    use case: 'a sparql engine'    

components.json
npm dataset (+LDN?)
components.js impl (instantiation of components.json)

use case: ldf server

conclusion
```