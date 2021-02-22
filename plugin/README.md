<!-- Plugin description -->
An Android studio plugin to support [Telereso](https://telereso.io?utm_source=github&utm_medium=readme-plugin&utm_campaign=normal)
<!-- Plugin description end -->

## Features
### Export strings.xml as json
to be able to migrate your local strings to firebase remote config they should converted from `xml` to `json` .

#### Export All strings.xml
In your tools dropdown menu search for `Telereso` Option then select `Export strings as json` , <br>
A folder called `.telereso` in your root project will be created, <br>
Inside it will be a `strings` folder containg all your local strings as key/value json,<br> 
The file nameing is compatble with [Telereso](https://telereso.io?utm_source=github&utm_medium=readme-plugin&utm_campaign=normal) library

#### Export A strings.xml
If you like to export the current `strings.xml` file you have opend in your editor , right click then select `Export as json`, <br>
You can use the shortcut <kbd>control</kbd>+<kbd>option</kbd>+<kbd>J</kbd>


