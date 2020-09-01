# Challenge
This is a coding challenge involving multiple iOS skills such as universal app, master/detail, page controller, json decoding, swift-objectiveC interaction, and following instructions.

Notes:
The class names are intentionally simple in order to indicate their role in the project

ViewModel
A ViewModel is definitely overkill for this project. But, if you wanted to do things with the data coming in, like sorting, or editing, or persisting, then this would be were you could handle that business type logic.

UITests
These were written for the iPad. Tests that would not pass if an iphone simulator was running the tests were intentionally passed.  The single test that could support both was left without that check.

ViewController
I normally don't include the delegate and datasource functions in my viewcontroller file.  However, the storyboard required that the master controller be a Tableview. I did not want to spend too much time trying to work around this.  I could have written it programmatically to keep the code structured as I liked, but figured demonstrating the "Apple" way might be better for this exercise.

Tests
I wrote more tests than required by the assignment. But I think tests are really important.

