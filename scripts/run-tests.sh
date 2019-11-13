export TEST_WATCH="${TEST_WATCH:-1}"

meteor test \
  --driver-package="meteortesting:mocha" \
  --raw-logs \
  --once
