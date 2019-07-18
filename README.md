# eventgen-container

This project contains a simple Dockerfile and Splunk configuration files to build a container running Splunk Eventgen.  To build the container you must add publicly accessible URLs for 4 items within the Dockerfile:

* Python 2.7 compiled with ucs2 unicode
* Archive containing Python libraries copied from a Splunk Enterprise installation
* Splunk Universal Forwarder
* Splunk Eventgen

When the container is started you must supply 2 environment variables:

* TARGETHOST - this is the destination host(s) to which you want to send data
* APPSURL - URL to a zip file containing the Eventgen apps you wish to execute in the container
