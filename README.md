# Reference

1. Using Trigger Framework by [Kevin O'Hara](https://github.com/kevinohara80/sfdc-trigger-framework)
2. Using lighting Components by [lightningstrike](https://github.com/appiphony/Strike-Components)
3. Using Connected Api helper class by [forcedotcom](https://github.com/forcedotcom/ConnectApiHelper)
4. Using Git Actions to deploy inspired by [Salto](https://github.com/salto-io/salesforce-ci-cd-org-dev)

# Overview

Basic Code Structure for any project

#### Trigger Helper

1. TriggerHandler class for creating trigger helpers

#### Aura Components

1. strike_lookup component for creating lookup fields no need to write all functinality just pass attributes
2. strike_modal component to use modal without banging head for modal css

### Utility Classes

1. TestDataFactory : test class data helper class

   a.getAdminUser() : returns system admin user

   b.getStandardUser() : returns standard user

   c.createContentVersion(Boolean isInsert) : return contentVersion

2. Log : loging helper class to unify loging to system

   a.exception(Exception ex),exception(Exception ex,String msg) : logs exception with error logging level and add exception data

   b.error(String msg) : logs message with error loging level

   c.warn(String msg) : logs message with warn loging level

   d.info(String msg) : logs message with info loging level

   e.debug(String msg) : logs message with debug loging level

3. UITheme : Get Users current displayed theam

   a.getTheme() : returns users current view state theme

### Chatter Helper Classes

1. ConnectApiHelper : helper class to post message to chattter

   a.createFeedItemInputFromBody(): add's text to exsisitng chatter message



# Git deployment

## PR 
1. Create a new PR with related components to deploy
2. On Create of PR,package check will occurs with production org

### Specify Test class to run as comma separated values in pr

    Apex::[LogTest]::Apex

### Specify all as value to run all local tests

    Apex::[all]::Apex

## Push to master
1. On push comment add "[Deploy]" in comment to mark it as deployment 
2. in case summary add Apex::[T]::Apex to run specific class during deployment


3. on successfully merge it will be deployed to production org



### Note
add git secrete variable

SFDX_PRODUCTION_URL

and value of it copy from running command

`sfdx force:org:display --targetusername <orgname> --verbose`

and copy Sfdx Auth Url