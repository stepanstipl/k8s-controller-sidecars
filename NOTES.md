- The controller only cleans up containers in default namespace

- to make this work for us
  - make listen to all-namespaces or parametrize which one (or both)
  - maybe drop the requiremetn of annotation and add 'istio-pilot' as default
    option for sidecars 
  - setup CI flow for building & publishing docker image
