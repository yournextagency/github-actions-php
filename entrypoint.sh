#!/bin/sh

cp /action/problem-matcher.json /github/workflow/problem-matcher.json

echo "::add-matcher::${RUNNER_TEMP}/_github_workflow/problem-matcher.json"

EXTENSIONS_FLAG=""
if [ -n "${INPUT_PHPCS_EXTENSIONS}" ]; then
    EXTENSIONS_FLAG="--extensions=${INPUT_PHPCS_EXTENSIONS}"
fi

if [ -z "${INPUT_ENABLE_WARNINGS}" ] || [ "${INPUT_ENABLE_WARNINGS}" = "false" ]; then
    echo "Check for warnings disabled"

    ${INPUT_PHPCS_BIN_PATH} -n --standard=YNA --report=checkstyle --ignore=${INPUT_PHPCS_IGNORE_PATHS} ${EXTENSIONS_FLAG} ${INPUT_PHPCS_PATHS}
else
    echo "Check for warnings enabled"

    ${INPUT_PHPCS_BIN_PATH} --standard=YNA --report=checkstyle --ignore=${INPUT_PHPCS_IGNORE_PATHS} ${EXTENSIONS_FLAG} ${INPUT_PHPCS_PATHS}
fi

status=$?

echo "::remove-matcher owner=phpcs::"

exit $status