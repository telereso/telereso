![Banner](doc/banner.svg)

[![jitpack](https://jitpack.io/v/ahna92/telereso.svg)](https://jitpack.io/#ahna92/telereso)

Table of contents:

* auto-gen TOC:
{:toc}
 
## Installation

All you need to get started is just to add a dependency to `Telereso` library.

#### Gradle/maven dependency
<table>
<thead><tr><th>Approach</th><th>Instruction</th></tr></thead>
<tr>
<td><img src="doc/gradle.png" alt="Gradle"/></td>
<td>
    <pre>implementation "com.github.ahna92:telereso:0.0.1"</pre>
    </td>
</tr>
<tr>
<td><img src="doc/gradle.png" alt="Gradle"/> (Kotlin DSL)</td>
<td>
    <pre>implementation("com.github.ahna92:telereso:0.0.1")</pre>
    </td>
</tr>
</table>

## Usage
There is different scenarios to work with telereso , wither you have a fresh new application you're building or already in production with large code base

### Android

#### Add `RemoteViewInflater`
This inflater will make sure all the android application views that display strings or images have the remote functionality ,
The inflater will detect if you're setting the text in the xml directly like `andriod:text=@stirngs/user_name` 
and use the remote version if it's found or default back to the original value
The inflater handles the following views :
* TextView
* EditText
* ImageView
* Button
* ImageButton
* FloatingActionButton
* BottomNavigationView
* NavigationView

*App Theme*

If your activities Does not use their own custom theme , add `RemoteViewInflater` directly to the app theme as the `viewInflaterClass`
```xml
    <style name="AppTheme" parent="Theme.AppCompat.Light.NoActionBar">
        <item name="colorPrimary">@color/style_color_primary</item>
        <item name="colorPrimaryDark">@color/style_color_primary_dark</item>
        <item name="colorAccent">@color/style_color_accent</item>
        <item name="colorControlHighlight">@color/fab_color_pressed</item>
        <item name="viewInflaterClass">io.telereso.android.RemoteViewInflater</item>
    </style>
```
*Activity Theme*

if your activity uses a custom theme add `RemoteViewInflater` to that theme
```xml
    <style name="AppTheme.TransparentActivity">
        <item name="android:windowBackground">@android:color/transparent</item>
        <item name="android:windowIsTranslucent">true</item>
        <item name="viewInflaterClass">io.telereso.android.RemoteViewInflater</item>
    </style>
```

#### Dynamic Resources
Sometimes we set the resrouces programmatically depending on a view state like so 
`title = getString(R.strings.title_home)`,
in this case we can use the Remote version of the function `getString()` which is 
`getRemoteString()` this will make sure to use the remote version of the resource
if found or default it to the original value

*Strings*

_kotlin_
```kotlin
titleTextView.text = getRemoteString(R.strings.title_home)
```
_java_
```java
titleTextView.setText(Telereso.getRemoteString(R.strings.title_home));
```

*Drawables*

_kotlin_
```kotlin
imageView.setRemoteImageResource(R.id.icon)
```
_java_
```java
Telereso.setRemoteImageResource(imageView,R.id.icon);
```

## Telereso API

Here are tables to help you use the library.

### Kotlin

|Function|Description|
|--------|-----------|
|`getRemoteString(R.string.<string_id>)`|return remote string or original value|

### Java

|Function|Description|
|--------|-----------|
|`Telereso.getRemoteString(R.string.<string_id>)`|return remote string or original value|

## Getting Help

To report bugs, please use the GitHub project.

* Project Page: [https://github.com/ahna92/telereso](https://github.com/ahna92/telereso)
* Reporting Bugs: [https://github.com/ahna92/telereso/issues](https://github.com/ahna92/telereso/issues)

## Logo Credit
[Created my free logo at LogoMakr.com](https://logomakr.com/)
