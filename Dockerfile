FROM ruby:2.7.1

RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    less \
    postgresql-client \
    nodejs

WORKDIR /backend

# Set yarn version
ENV YARN_VERSION 1.21.1

RUN curl -fSLO --compressed "https://yarnpkg.com/downloads/$YARN_VERSION/yarn-v$YARN_VERSION.tar.gz" \
  && tar -xzf yarn-v$YARN_VERSION.tar.gz -C /opt/ \
  && ln -snf /opt/yarn-v$YARN_VERSION/bin/yarn /usr/local/bin/yarn \
  && ln -snf /opt/yarn-v$YARN_VERSION/bin/yarnpkg /usr/local/bin/yarnpkg \
  && rm yarn-v$YARN_VERSION.tar.gz

COPY lib ./lib

COPY Gemfile Gemfile.lock ./
RUN gem install bundler && bundle install --jobs 20 --retry 5

COPY . .

EXPOSE 3000

# So we don't have to specify "bundle exec" for each of our commands
ENTRYPOINT ['bundle', 'exec']

CMD ["rails", "server", "-p", "3000", "-b", "0.0.0.0"]