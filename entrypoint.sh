#!/bin/bash
set -e
# Remove a potentially pre-existing server.pid for Rails.
if [ -f /rain/tmp/pids/server.pid ]; then
  rm /rain/tmp/pids/server.pid
fi

bundle exec rake db:migrate 2>/dev/null || bundle exec rake db:setup
bundle exec rake assets:precompile

echo "Setup down"

exec "$@"
