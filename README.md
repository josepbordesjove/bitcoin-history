#  Bitcoin history projecet

This project has been structured with 3 main targets and 2 tests targets (Main app tests and thee kit tests):

## Main targets

### 1. Bitcoin history (main app)
This target is where the UI scenes of the app are handled. This app consists of two scenes; master and detail. It has been structured in that way to use the epower of UISplitViewController and have an iPad and iPhone app at the same time. Also this structure can be used to get a mac app using projecet Catalyst.

To handle the loading state in the master list, placeholder cells have beeen created, and while results are fetched are presented. Otherwise in the detail view, a placeholder view with a cta has been used, as the detail in iPad is bigger than thee main scene, and it looks nicer in both platforms (iOS and iPad).

### 2. Today extension
This extensions fetch the today rate for the device currency locale, and updates it every 10 seconds

### 3. BHKit
This kit has been created in order to share code beetween the main app and the today extension. It handles the main logic, and it's main functionality is to fetch the data from the network and unify it to make it easier to handle the presentation in the UI.

It has been created in order to make the code testable and the classes that handles heavy work are separated with dependency injection to inject a Mem in case no heavy work is wantede to be done.

In the Date+ (Date extension), the date formatter and the calendar have been created as static to only create those instances once, as the cost to load them are heavy.

