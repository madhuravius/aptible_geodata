SHELL := /bin/bash
PYTHON_ENV := . .venv/bin/activate
PYTHON := ${PYTHON_ENV} && python

install: .venv
	$(PYTHON) -m pip install -e .[dev]
	$(PYTHON_ENV) && jupyter labextension install @jupyter-widgets/jupyterlab-manager keplergl-jupyter
	$(PYTHON_ENV) && jt -t monokai -N -kl -cursw 5 -cursc r -cellw 95% -T

.venv:
	python -m venv .venv

pretty: pretty_black pretty_isort

pretty_black:
	$(PYTHON) -m black .

pretty_isort:
	$(PYTHON) -m isort .

tests: install pytest isort_check black_check

pytest:
	$(PYTHON) -m pytest --cov=./app

pytest_loud:
	$(PYTHON) -m pytest -s  --cov=./app

isort_check:
	$(PYTHON) -m isort --check-only .

black_check:
	$(PYTHON) -m black . --check

start:
	$(PYTHON) -m jupyter notebook