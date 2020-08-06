# Accurics CircleCI Orb

## Description
The Accurics CircleCI Orb runs an Accurics scan against the IaC (Infrastructure-as-Code) files found within the applied repository.
This action can be used to fail a pipeline build when violations or errors are found.
The scan results can be viewed in the pipeline results or in the Accurics Console itself at https://app.accurics.com

See examples below.

## Setup

```yaml
version: 2.1
orbs:
  accurics: accurics/accurics-cli@x.y.z
workflows:
  deploy:
    jobs:
      - accurics/accurics_scan:
          terraform-version: latest
          directories: ./your-root
          plan-args: -var your-var=your-value
          fail-on-violations: false
          fail-on-all-errors: true
```

- Create CircleCI environmental variables to store the Environment ID and Application Token. Create two environmental variables called "ACCURICS_API_KEY" and "ACCURICS_ENV_ID" filled with the "app" and "env" values copied from the config file downloaded from the Accurics UI environment tab.
- Add CircleCI environmental variables for your Cloud provider, e.g., AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY.
- Add a "repo" parameter that contains the remote repo location.
- If not using the latest Terraform version, specify the "terraform-version" parameter within the build step.
- If variables are used, add them in the "plan-args" parameter, along with any other command line parameters that should be passed when running "terraform plan" (see the example below)

## Cost

The Accurics Accurics CircleCI Orb runs as a Linux container, which means it accumulates minutes while running at the same rate Linux containers are charged by CircleCI. Please refer to the CircleCI action billing page for more detailed information.

## Input Settings

### These settings are required
| Setting | Description |
| -------------------- | ----------------------------------------------------------- |
| app-id | The application token ID |
| env-id | The environment ID |
| repo   | The repository location URL |

### All of the following settings are optional

| Setting | Description | Default |
| -------------------- | ----------------------------------------------------------- | --------- |
| terraform-version | The Terraform version used to process the files in this repository | latest | 
| plan-args | The Terraform version used to process the files in this repository | | 
| directories | A list of directories to scan within this repository separated by a space | ./ | 
| fail-on-violations | Allows the Accurics Action to fail the build when violations are found | true |
| fail-on-all-errors | Allows the Accurics Action to fail the build when any errors are encountered | true |

### Notes
- Variable values within the plan-args setting should be stripped of single-quote (') characters

## Examples

### Example 1:
This example configures an Accurics Scan with a custom Terraform version and variables. It will also fail the build on any violations or errors found.

```yaml
version: 2.1
orbs:
  accurics: accurics/accurics-cli@x.y.z
workflows:
  deploy:
    jobs:
      - accurics/accurics_scan:
          terraform-version: 0.12.24
          plan-args: -var your-var=your-value
          fail-on-violations: true
```

### Example 2:
This example configures an Accurics Scan using the latest Terraform version, custom variables, and instructs the action not to fail when any violations are found. This is helpful when first introducing the action into a new codebase and working through a large number of violations. Once the number of violations is manageable, the option can be set back to true (or removed).
```yaml
version: 2.1
orbs:
  accurics: accurics/accurics-cli@x.y.z
workflows:
  deploy:
    jobs:
      - accurics/accurics_scan:
          terraform-version: latest
          directories: ./your-root
          plan-args: '-var myvar1=val1 -var myvar2=val2'
          fail-on-violations: false
```
