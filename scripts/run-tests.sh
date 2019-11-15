SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"

export METEOR="${METEOR:-$(which devmeteor)}"

export WORK_ROOT="${WORK_ROOT:-${DIR}/..}"
export METEOR_PACKAGE_DIRS="${HOME}/meteor/packages:${WORK_ROOT}/packages"
export TEST_WATCH="${TEST_WATCH:-1}"
export TEST_METADATA='{"driverPackage":"meteortesting:mocha","isAppTest":false,"isTest":true}'
# export TEST_METADATA='{"isAppTest":false,"isTest":true}'
export TEST_BROWSER_DRIVER=phantomjs

set -e

cd "${WORK_ROOT}"

# mocha test --require ts-node/register imports/api/match/*.test.ts
${METEOR} test \
  --driver-package="meteortesting:mocha" \
  --raw-logs \
  --once
# meteor test --full-app --driver-package practicalmeteor:mocha

unset TEST_METADATA
unset METEOR_PACKAGE_DIRS

set +e
