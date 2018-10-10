#!/bin/bash
set -euxo pipefail

cd /hackmd

if ! [ -f /config/config.json ]; then
	cp config.json.default config.json
else
	cp /config/config.json config.json
fi

if ! [ -f /config/.sequelizerc ]; then
	cp .sequelizerc.default .sequelizerc
else
	cp /config/.sequelizerc .sequelizerc
fi

if [ -f /config/client_config.js ]; then
	cp /config/client_config.js public/js/config.js
fi

node_modules/.bin/sequelize db:migrate

exec npm run start
