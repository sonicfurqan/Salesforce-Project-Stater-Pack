# Curtacy

1. Using Trigger Framework by [Kevin O'Hara](https://github.com/kevinohara80/sfdc-trigger-framework)
2. Using lighting Components by [lightningstrike](https://github.com/appiphony/Strike-Components)
3. Using Connected Api helper class by [forcedotcom](https://github.com/forcedotcom/ConnectApiHelper)

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

### Package Development Model
