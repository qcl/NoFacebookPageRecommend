chrome: QCLean-Chrome-Experiment
	cd ./QCLean-Chrome-Experiment; jsx -x jsx src build --no-cache-dir
	zip -r qclean-chrome.zip QCLean-Chrome-Experiment

chrome-old: QCLean-Chrome
	zip -r qclean-chrome-old.zip QCLean-Chrome

chrome-crx: QCLean-Chrome
	google-chrome --pack-extension=QCLean-Chrome

firefox: firefox-l10n-patch

firefox-l10n-patch: firefox-xpi
	unzip qclean-firefox.xpi install.rdf
	patch -p0 < ./QCLean-Firefox/install.rdf.l10n.patch
	zip qclean-firefox.xpi install.rdf
	rm install.rdf

firefox-xpi-jpm: QCLean-Firefox-Experiment firefox-check-jpm
	cd ./QCLean-Firefox-Experiment; jpm xpi; mv *.xpi ../qclean-firefox.xpi

firefox-check-jpm:
	@which jpm > /dev/null

firefox-xpi: QCLean-Firefox firefox-sdk
	cd firefox-sdk; . bin/activate; cd ../QCLean-Firefox/; cfx xpi; mv qclean-remove-facebook-ads-suggested-pages-and-posts.xpi ../qclean-firefox.xpi

firefox-sdk:
	wget https://ftp.mozilla.org/pub/mozilla.org/labs/jetpack/jetpack-sdk-latest.zip
	unzip jetpack-sdk-latest.zip
	rm jetpack-sdk-latest.zip
	mv addon-sdk-* firefox-sdk

firefox-webext: QCLean-Firefox-Web-Extension
	zip -r qclean-firefox.zip QCLean-Firefox-Web-Extension

opera-linux: QCLean-Opera-12
	cd QCLean-Opera-12; zip -r qclean-opera-linux.oex *; mv qclean-opera-linux.oex ../

opera: QCLean-Opera-15+
	cd QCLean-Opera-15+; zip -r qclean-opera.crx *; mv qclean-opera.crx ../

ie: QCLean-IE.js
	cp QCLean-IE.js ~/Dropbox/Public/ie.js

clean:
	rm -f qclean-chrome.zip
	rm -f jetpack-sdk-latest.zip
	rm -f qclean-firefox.xpi
	rm -f qclean-opera-linux.oex
	rm -f qclean-opera.crx
	rm -f qclean-firefox.zip

