WORK_HOME ?= $(HOME)/.venv
VIRTUAL_ENV ?= $(WORK_HOME)/pavlov-central
PYTHON=${VENV_NAME}/bin/python3
PATH := $(VIRTUAL_ENV)/bin:$(PATH)
MAKE := $(MAKE) --no-print-directory
SHELL = bash

.PHONY: default info prepare-dev install reset check test clean

default:
	@echo 'Makefile for Pavlov Central'
	@echo
	@echo 'Usage:'
	@echo
	@echo '    make prepare-dev   prepare development environment, use only once'
	@echo '    make install       install the package in a virtual environment'
	@echo '    make reset         recreate the virtual environment'
	@echo '    make check         check coding style (PEP-8, PEP-257)'
	@echo '    make test          run the test suite, report coverage'
	@echo '    make clean         cleanup all temporary files'
	@echo

info:
	@echo make 			= $(MAKE)
	@echo virtual env 	= $(VIRTUAL_ENV)

prepare-dev:
	python3 -m pip install --upgrade pip
	python3 -m pip install virtualenv
	python3 -m pip install pytest

install:
	@test -d "$(VIRTUAL_ENV)" || mkdir -p "$(VIRTUAL_ENV)"
	@test -x "$(VIRTUAL_ENV)/bin/python3" || virtualenv --python=python3 --system-site-packages --quiet "$(VIRTUAL_ENV)"
	@test -x "$(VIRTUAL_ENV)/bin/pip" || easy_install pip
	@pip install --quiet --requirement=requirements.txt
	@pip uninstall --yes pavlov_central &>/dev/null || true
	@pip install --quiet --no-deps --ignore-installed .

reset:
	$(MAKE) clean
	$(MAKE) clean-venv
	$(MAKE) install

check: install
	@pip install --upgrade --quiet --requirement=requirements-checks.txt
	@flake8

test: install
#	@pip install --quiet --requirement=requirements-tests.txt
#	@echo pytest --cov=DeviceBackend/ --cov-report term-missing
#	@echo coverage report --fail-under=7
	@echo 'no tests found'

clean:
	@rm -Rf *.egg .eggs *.egg-info *.db .cache .coverage .tox build dist htmlcov test/.Python test/pip-selfcheck.json test/lib/ test/include/ test/bin/
	@find . -depth -type d -name __pycache__ -exec rm -Rf {} \;
	@find . -type f -name '*.pyc' -delete

clean-venv:
	rm -Rf "$(VIRTUAL_ENV)"
