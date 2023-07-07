.PHONY: clean

clean:
	rm -rf chromium.zip _/amazon/code/nodejs _/amazon/handlers/node_modules

pretest:
	unzip chromium.zip -d _/amazon/code
	npm install --prefix _/amazon/handlers puppeteer-core@latest --bin-links=false --fund=false --omit=optional --omit=dev --package-lock=false --save=false

test:
	sam local invoke --template _/amazon/template.yml --event _/amazon/events/example.com.json node18

.fonts.zip:
	zip -9 --filesync --move --recurse-paths .fonts.zip .fonts/

%.zip:
	npm install --fund=false --package-lock=false
	mkdir -p nodejs
	mv node_modules nodejs/node_modules
	zip -9 --filesync --move --recurse-paths $@ nodejs

.DEFAULT_GOAL := puppeteer-core.zip
