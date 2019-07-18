FROM ubuntu:16.04

RUN \
	apt-get update && \
	apt -y autoremove python2.7 && \
	apt-get -y upgrade && \
	apt-get -y install unzip wget && \
	wget -O /tmp/python.dpkg ##REPLACE WITH URL FOR PYTHON 2.7 UCS2 DEBIAN PACKAGE## && \
	dpkg -i /tmp/python.dpkg && \
	rm -f /tmp/python.dpkg && \
	wget -O /tmp/get-pip.py https://bootstrap.pypa.io/get-pip.py && \
	python /tmp/get-pip.py && \
	rm -f /tmp/get-pip.py && \
	pip install jinja2 && \
	wget -O /tmp/splunk-py.tgz ##REPLACE WITH URL FOR TGZ ARCHIVE CONTAINING LIBRARIES FROM SPLUNK ENTERPRISE PYTHON## && \
	tar xvzf /tmp/splunk-py.tgz -C /usr/local/lib/python2.7/ && \
	rm -f /tmp/splunk-py.tgz && \
	wget -O /tmp/splunk-forwarder.tgz ##REPLACE WITH URL FOR SPLUNK UF TGZ ARCHIVE## && \
	tar xvzf /tmp/splunk-forwarder.tgz -C /opt && \
	rm -f /tmp/splunk-forwarder.tgz && \
	wget -O /tmp/eventgen.tgz ##REPLACE WITH URL FOR SPLUNK EVENTGEN TGZ ARCHIVE## && \
	tar xvzf /tmp/eventgen.tgz -C /opt/splunkforwarder/etc/apps/ && \
	rm -f /tmp/eventgen.tgz && \
	mkdir -p /opt/splunkforwarder/etc/apps/SA-Eventgen/local/ && \
	pip install --upgrade --force-reinstall lxml

COPY scripts/inputs.conf /opt/splunkforwarder/etc/apps/SA-Eventgen/local/inputs.conf
RUN \
	echo '[monitor:///opt/splunkforwarder/var/log/splunk]' >> /opt/splunkforwarder/etc/system/local/inputs.conf && \
	echo 'blacklist = eventgen_metrics\.log' >> /opt/splunkforwarder/etc/system/local/inputs.conf

COPY scripts/entrypoint.sh /sbin/entrypoint.sh
COPY scripts/outputs.conf /opt/splunkforwarder/etc/system/local/outputs.conf
COPY scripts/user-seed.conf /opt/splunkforwarder/etc/system/local/user-seed.conf
RUN ["chmod", "+x", "/sbin/entrypoint.sh"]
ENTRYPOINT ["/sbin/entrypoint.sh"]
