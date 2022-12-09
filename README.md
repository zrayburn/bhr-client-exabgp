# BHR Block manager that uses [ExaBGP](https://github.com/Exa-Networks/exabgp)

See the example configuration files in examples/

Site specific configuration is made up of:

* The bhr client configuration - the environment variables `BHR_HOST`, `BHR_TOKEN`, and `BHR_IDENT`
* The exabgp configuration template.

## Configuration Template
The configuration template is a [Mako template](http://docs.makotemplates.org/en/latest/syntax.html) for exabgp.

The lines like

    attribute next-hop self community [ 65142:666 no-export ] nlri ${cidrs}

should be changed to match what your router is expecting.

Otherwise, the rest of the settings like `peer-as`, `local-as` should be
configured per the exabgp documentation.

## Configuring BHR-Site autorization token
Getting the bhr-client loop to connect to bhr-site and fetch block lists requires BHR_TOKEN to be populated.

1. Go to http://localhost:8000/admin (Or wherever your BHR-site is hosted)
2. Click on tokens, select your desired user, and click save
3. Copy the resultant token to examples/start_container in the BHR_TOKEN environment variable

## Starting BHR-client-exabgp
BHR-client-exabgp runs inside of a docker container where the current config on disk is copied into the docker container. This as well as exabgp installation happens when you build the container locally.
The instructions for building and running are as follows:
1. Copy examples/template.mako to project root
2. Modify ./template.mako with the correct exabgp commands for your router
3. Build the docker image `docker build -t bhr-client-exabgp:latest .`
4. Modify examples/start_container with the correct env and options
5. Start the connector `bash examples/start_container`