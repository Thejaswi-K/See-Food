See Food App Description:
The See Food App uses a pre-trained ML Model preloaded in the device to classify the food picture captured by camera or picked from photo albums. It also gives you the description fetched from wikipedia on the click of a button. You can also save the pictures with their classification and description. 
—————————————————————————————————————————————————————————————————————————————————————————————————————————-
Flow of the App:
The initial screen presents with options to click a picture or choose a picture from the library. The user can do either option and the image chosen is previewed on the screen with Identify button now active. On clicking it the user is presented with another screen where the image is identified and a description is provided. The user can save this result to view it later using the button at the bottom of the screen. On clicking the button the screen is back to the initial screen. The user can save another picture or click the folder icon below in the toolbar which takes him to another screen presenting the saved results. The user can view these results even after shutting down the app and restarting it. The user can view each result again on clicking the appropriate row or swipe left to delete the results.

—————————————————————————————————————————————————————————————————————————————————————————————————————————-
Libraries used:
Core Data
Vision
CoreML

Third party Cocoapods libraries used:
Alamofire
SwiftyJSON

—————————————————————————————————————————————————————————————————————————————————————————————————————————-
Instructions to install third party libraries:

Command to install cocoa pods
sudo gem install cocoapods

Navigate to the project folder and enter the following command
pod init

This creates a pod file. Open it and enter the following lines
pod 'Alamofire' 
pod 'SwiftyJSON'

After entering those go back to terminal and enter the following command
pod install

Voila!
—————————————————————————————————————————————————————————————————————————————————————————————————————————-

Downloaded the .mlmodel file from the link below
https://drive.google.com/file/d/0B5TjkH3njRqnVjBPZGRZbkNITjA/view 
—————————————————————————————————————————————————————————————————————————————————————————————————————————-

