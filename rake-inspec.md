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


## Test planning: RHEL Environment testing for Terraform
 Before passing environments to develoment teams, we want to verify API endpoints function as expected.
```
# AC:
Ability to run test "suite" against an environment
Ability to run test "suite" specific to an application in an environment
```


 ## Test planning: Routine for preflight
 Assuming the use of rake to perform testing tasks, create a task for "preflight" to check that the system running the task has all necessary requirements to perform the task or returns the user a useful message to install required tools.

# Rake Test Execution

## What is Rake?
  Rake is Ruby Make, a standalone Ruby utility that replaces the Unix utility 'make', and uses a 'Rakefile' and .rake files to build up a list of tasks. In Rails, Rake is used for common administration tasks, especially sophisticated ones that build off of each other.
You can get a list of Rake tasks available to you, which will often depend on your current directory, by typing rake --tasks. Each task has a description, and should help you find the thing you need.

To get the full backtrace for running rake task you can pass the option --trace to command line, for example rake db:create --trace.
  Rake enables you to define a set of tasks and the dependencies between them in a file, and then have the right thing happen when you run any given task.

## Why Rake?
  It was originally created to handle software build processes,
  but has made it the standard method of job automation for Ruby projects.

## How to use Rake?
  No need to install Rake. Rake is now part of the Ruby standard library. Create a "Rakefile" in your work folder

# Sample execution code

```
$ rake preflight
preflight passed

$ rake preflight env[kesha]
preflight passed
ENV['ANA_ENV']=kesha

OLD 
$ rake preflight env[kesha] verify[api]
NEW 
$ rake preflight RAILS_ENV=kesha  verify[api]

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
