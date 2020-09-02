# Challenge
This is a coding challenge involving multiple iOS skills such as universal app, master/detail, page controller, json decoding, swift-objectiveC interaction, and following instructions.

Notes:
I have one  bug I was not yet able to fix.  If touch a row in the table (for example: "6" and then scroll down and touch a row, "18" - When you scroll back up, "6" is still highlighted.  This only happens for cells not in the same "view" ie, you have to scroll some to get from one to the other. Scrolling back down again and up will clear the "6."  When you swipe between the pages, the rows highlight appropriately.  However, you have to make sure you fully move to the next page, or it may not register.  

Also, when the app opens in landscape, the master controller is 1/2 the width as described. When you move to portrait and touch the Numbers! (back button), the master controller displays smaller.  Rotating it to landscape will return to the 1/2 controller and the cells all correctly resize.

The class names are intentionally simple in order to indicate their role in the project

ViewModel
A ViewModel is definitely overkill for this project. But, if you wanted to do things with the data coming in, like sorting, or editing, or persisting, then this would be were you could handle that business type logic.

UITests
These were written for the iPad. Tests that would not pass if an iphone simulator was running were intentionally passed.  The single test that could support both was left without that check.

ViewController
I normally don't include the delegate and datasource functions in my viewcontroller file.  However, the storyboard required that the master controller be a Tableview. I did not want to spend too much time trying to work around this.  I could have written it programmatically to keep the code structured as I liked, but figured demonstrating the "Apple" way might be better for this exercise.

ObjectiveC
It's not a full class included.  It's a category on NSString. It was very handy. The BridgingHeader treated it just like it does a class. The function in this category replaces http as received from the server with https, to avoid transport errors which was preventing download of the images.  The initial call to the server is made from the result of func url() in Constants.swift which uses https instead of http.

debug.xcconfig
I added an xcconfig file to store the api endpoint. I added this file as a "Configuration" for debug version in the plist. In a production environment, we would have a config file for each environment scheme, debug, qa, release, etc.

Tests
I wrote more tests than required by the assignment. But I think tests are really important. 

