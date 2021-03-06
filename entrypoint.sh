#!/bin/sh

cp /action/problem-matcher.json /github/workflow/problem-matcher.json

echo "::add-matcher::${RUNNER_TEMP}/_github_workflow/problem-matcher.json"

if [ -z "${INPUT_ENABLE_WARNINGS}" ] || [ "${INPUT_ENABLE_WARNINGS}" = "false" ]; then
    echo "Check for warnings disabled"

    ${INPUT_PHPCS_BIN_PATH} -n --standard=Supercraft --standatd--report=checkstyle --ignore=*/tests/*,*/data/*,*/libraries/* ${INPUT_PHPCS_PATHS}
else
    echo "Check for warnings enabled"

    ${INPUT_PHPCS_BIN_PATH} --standard=Supercraft --report=checkstyle --ignore=*/tests/*,*/data/*,*/libraries/* ${INPUT_PHPCS_PATHS}
fi

/root/.composer/vendor/friendsoftwig/twigcs/bin/twigcs --ruleset \\supercraft\\SupercraftRuleset ${INPUT_TWIGCS_PATHS}

status=$?

echo "::remove-matcher owner=phpcs::"

exit $status
