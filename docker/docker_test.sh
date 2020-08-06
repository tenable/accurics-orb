#!/bin/sh

test_cli_installed() {
    echo "Testing accurics-cli is installed"
    /usr/bin/accurics version | grep "Terraform version"
    exit_code=$?

    if [ $exit_code != 0 ]; then
	    return
    fi

    /run-scan.sh | grep "The env-id parameter is required"

    exit_code=$?
}

main() {
    exit_code=0
    test_cli_installed

    if [ $exit_code = 0 ]; then
	    echo "Tests passed"
    else
	    echo "Tests failed"
    fi

    exit $exit_code
}

main
