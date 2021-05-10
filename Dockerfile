# Dockerfile

FROM ruby:2.5.1

WORKDIR /code
COPY . /code
RUN bundle install

EXPOSE 6995

CMD ["bundle", "exec", "rackup", "--host", "0.0.0.0", "-p", "6995"]