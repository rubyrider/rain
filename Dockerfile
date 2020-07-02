FROM ruby:2.7.1

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client nodejs yarn

RUN mkdir /rain
WORKDIR /rain
COPY Gemfile /rain/Gemfile
COPY Gemfile.lock /rain/Gemfile.lock
RUN bundle install
COPY . /rain
RUN yarn install --check-files
COPY entrypoint.sh /usr/bin
RUN chmod a+x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

EXPOSE 3000

CMD ["rails", "s", "-b", "0.0.0.0"]
