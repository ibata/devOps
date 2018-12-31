# Craft RAKE strategy
 Since Chef is in Ruby, we should likely use rake to control "tasks" for the testing structure. Investigate strategy/organization of testing to supply inputs to rake to test environments and applications of environments

## Benefit
- The outcome of the test is to report the quality of the product
- To build shared confidence in the code base
- To validate infrastructure
- Easier to narrow down application issues to environmental/infrastructure issues.
- Enable teams to make changes with confidence.
- Application is working as expected

## Strategy
- Get test documents + Api Review Meetings: Provide Development/System design documents that describe the functionality of the software to be enabled in the upcoming release. Which types of testing are to be performed?Api Non-functional endpoint testing
- Test planning:  JIRA stories: Api Non-functional endpoint testing
- Test development: create the test case
- Test execution: execute the tests based on the plans and test documents
- Test reporting: report to developers
- Test result analysis: decide what defects should be assigned, fixed, rejected
- Defect Retesting: retest after fixing defects.
- Regression testing: retest after adding new features
- Test Closure: document outcome and knowledge gathered


## Prerequisites
- Understand how your end-user developers are using your API.
- When developers are using the API
- Which endpoints they are using
- Which endpoints they are using more than the other(s)
- When they use one particular endpoint
- Why they use this particular endpoint
- What combination of endpoints they are calling


# RHEL Environment testing for Terraform
 Before passing environments to develoment teams, we want to verify API endpoints function as expected.
```
# AC:
Ability to run test "suite" against an environment
Ability to run test "suite" specific to an application in an environment
```


 # Routine for preflight
 Assuming the use of rake to perform testing tasks, create a task for "preflight" to check that the system running the task has all necessary requirements to perform the task or returns the user a useful message to install required tools.

# Rake Test Execution

## What is Rake?
  Rake enables you to define a set of tasks and the dependencies between them in a file, and then have the right thing happen when you run any given task.

## Why Rake?
  It was originally created to handle software build processes,
  but has made it the standard method of job automation for Ruby projects.

## How to use Rake?
  No need to install Rake. Rake is now part of the Ruby standard library. Create a "Rakefile" in your work folder

# Sample code

```
$ rake preflight
preflight passed

$ rake preflight env[kesha]
preflight passed
ENV['ANA_ENV']=kesha

$ rake preflight env[kesha] verify[api]
preflight passed
ENV['ANA_ENV']=kesha
inspec exec test/verify/controls/api.rb

Profile: tests from test/verify/controls/api.rb (tests from test.verify.controls.api.rb)
Version: (not specified)
Target:  local://

  ✔  site-domain: testing url
     ✔  http GET on http://**************.com status should eq 301
     ✔  http GET on http://**************.com headers.Location should eq "http://**************.com/"
     ✔  http GET on http://**************.com status should eq 200
     ✔  http GET on http://**************.com status should eq 302
     ✔  http GET on http://**************.com headers.Location should eq "http://**************.com/"
     ✔  http GET on http://**************.com status should eq 301
     ✔  http GET on http://**************.com headers.Location should eq "http://**************.com/"
     ✔  http GET on http://**************.com status should eq 403
     ✔  http GET on http://**************.com status should eq 302
     ✔  http GET on http://**************.com status should eq 301
     ✔  http GET on http://**************.com status should eq 403


Profile Summary: 1 successful control, 0 control failures, 0 controls skipped
Test Summary: 11 successful, 0 failures, 0 skipped
```
