PYTHON ?= python3
NPM ?= npm

.PHONY: setup verify feedback run run-backend package

setup:
	@shallow=$$(git rev-parse --is-shallow-repository) && \
	if [ "$$shallow" = "true" ]; then \
		git fetch --unshallow --tags origin; \
	fi
	$(NPM) ci

verify:
	$(NPM) run typecheck
	$(NPM) run lint
	$(NPM) run test:smoke

feedback: verify
	$(NPM) run audit:ci
	$(NPM) run bundle:release

run:
	$(NPM) run start

run-backend:
	$(NPM) run backend

package:
	$(NPM) run package:android

verify-week-%:
	$(PYTHON) tools/course_public_evaluator.py --week $* --mode verify --execute-toolchain

public-test-week-%:
	$(PYTHON) tools/course_public_evaluator.py --week $* --mode public --execute-toolchain

evidence-week-%:
	$(PYTHON) tools/course_public_evaluator.py --week $* --mode evidence
