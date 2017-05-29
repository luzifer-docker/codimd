FROM node:7

ENV VERSION                    master

# ENV DEBUG                      true
# ENV HMD_DOMAIN                 localhost
# ENV HMD_URL_PATH               ""
# ENV HMD_PORT                   3000
# ENV HMD_ALLOW_ORIGIN           localhost, hackmd.io
# ENV HMD_PROTOCOL_USESSL        true
# ENV HMD_URL_ADDPORT            true
# ENV HMD_USECDN                 true
# ENV HMD_ALLOW_ANONYMOUS        true
# ENV HMD_ALLOW_FREEURL          true
# ENV HMD_DEFAULT_PERMISSION     locked
# ENV HMD_DB_URL                 sqlite:///data/db.sqlite
# ENV HMD_FACEBOOK_CLIENTID      ""
# ENV HMD_FACEBOOK_CLIENTSECRET  ""
# ENV HMD_TWITTER_CONSUMERKEY    ""
# ENV HMD_TWITTER_CONSUMERSECRET ""
# ENV HMD_GITHUB_CLIENTID        ""
# ENV HMD_GITHUB_CLIENTSECRET    ""
# ENV HMD_GITLAB_SCOPE           api
# ENV HMD_GITLAB_BASEURL         ""
# ENV HMD_GITLAB_CLIENTID        ""
# ENV HMD_GITLAB_CLIENTSECRET    ""
# ENV HMD_DROPBOX_CLIENTID       ""
# ENV HMD_DROPBOX_CLIENTSECRET   ""
# ENV HMD_GOOGLE_CLIENTID        ""
# ENV HMD_GOOGLE_CLIENTSECRET    ""
# ENV HMD_LDAP_URL               ""
# ENV HMD_LDAP_BINDDN            ""
# ENV HMD_LDAP_BINDCREDENTIALS   ""
# ENV HMD_LDAP_TOKENSECRET       ""
# ENV HMD_LDAP_SEARCHBASE        ""
# ENV HMD_LDAP_SEARCHFILTER      ""
# ENV HMD_LDAP_SEARCHATTRIBUTES  ""
# ENV HMD_LDAP_TLS_CA            ""
# ENV HMD_LDAP_PROVIDERNAME      ""
# ENV HMD_IMGUR_CLIENTID         ""
# ENV HMD_EMAIL                  true
# ENV HMD_ALLOW_EMAIL_REGISTER   true
# ENV HMD_IMAGE_UPLOAD_TYPE      filesystem
# ENV HMD_S3_ACCESS_KEY_ID       ""
# ENV HMD_S3_SECRET_ACCESS_KEY   ""
# ENV HMD_S3_REGION              ""
# ENV HMD_S3_BUCKET              ""

RUN set -ex \
 && mkdir /hackmd \
 && curl -sSfL https://github.com/hackmdio/hackmd/archive/${VERSION}.tar.gz | tar -xzf - --strip-components=1 -C /hackmd

WORKDIR /hackmd

RUN set -ex \
 && npm install \
 && npm install webpack \
 && npm run build

ADD run.sh /usr/local/bin/run.sh
ADD config.json /hackmd/config.json.default
ADD sequelizerc /hackmd/.sequelizerc.default

EXPOSE 3000
VOLUME /config
VOLUME /data
VOLUME /hackmd/public/uploads

ENV NODE_ENV production

CMD ["/usr/local/bin/run.sh"]
