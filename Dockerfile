FROM ruby:2.7.1

RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    less \
    postgresql-client \
    nodejs


# Set yarn version
ENV YARN_VERSION 1.21.1

RUN curl -fSLO --compressed "https://yarnpkg.com/downloads/$YARN_VERSION/yarn-v$YARN_VERSION.tar.gz" \
  && tar -xzf yarn-v$YARN_VERSION.tar.gz -C /opt/ \
  && ln -snf /opt/yarn-v$YARN_VERSION/bin/yarn /usr/local/bin/yarn \
  && ln -snf /opt/yarn-v$YARN_VERSION/bin/yarnpkg /usr/local/bin/yarnpkg \
  && rm yarn-v$YARN_VERSION.tar.gz


WORKDIR /backend

EXPOSE 3000
ENTRYPOINT ['bundle', 'exec']
CMD ["rails", "server", "-p", "3000", "-b", "0.0.0.0"]