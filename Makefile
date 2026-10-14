.PHONY: lint check test

lint:
	uv run ruff check --fix .
	uv run ruff format .

# what CI runs
check:
	uv run ruff check .
	uv run ruff format --check preprocessing tests

test:
	uv run pytest
