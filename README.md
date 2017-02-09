
# react-native-custom-keyboard

## Getting started

`$ npm install react-native-custom-keyboard --save`

### Mostly automatic installation

`$ react-native link react-native-custom-keyboard`

### Manual installation


#### iOS

1. In XCode, in the project navigator, right click `Libraries` ➜ `Add Files to [your project's name]`
2. Go to `node_modules` ➜ `react-native-custom-keyboard` and add `RNCustomKeyboard.xcodeproj`
3. In XCode, in the project navigator, select your project. Add `libRNCustomKeyboard.a` to your project's `Build Phases` ➜ `Link Binary With Libraries`
4. Run your project (`Cmd+R`)<

#### Android

1. Open up `android/app/src/main/java/[...]/MainActivity.java`
  - Add `import cn.reactnative.customkeyboard.RNCustomKeyboardPackage;` to the imports at the top of the file
  - Add `new RNCustomKeyboardPackage()` to the list returned by the `getPackages()` method
2. Append the following lines to `android/settings.gradle`:
  	```
  	include ':react-native-custom-keyboard'
  	project(':react-native-custom-keyboard').projectDir = new File(rootProject.projectDir, 	'../node_modules/react-native-custom-keyboard/android')
  	```
3. Insert the following lines inside the dependencies block in `android/app/build.gradle`:
  	```
      compile project(':react-native-custom-keyboard')
  	```


## Usage

Register a component as custom keyboard: 

```javascript
import React, { Component } from 'react';
import {
  TouchableOpacity,
  Text,
  View,
} from 'react-native';
import { register, insertText } from 'react-native-custom-keyboard';

class MyKeyboard extends Component {
  onPress = () => {
    insertText(this.props.tag, 'Hello, world');
  };
  render() {
    return (
      <View>
        <TouchableOpacity onPress={this.onPress}>
          <Text>Hello, world</Text>
        </TouchableOpacity>
      </View>
    );
  }
}

register('hello', () => MyKeyboard);
```

Use `CustomTextInput` instead of `TextInput`.

```javascript
import React, { Component } from 'react';
import {CustomTextInput} from 'react-native-custom-keyboard';

class MyPage extends Component {
  state = {
    value: '';
  };
  onChangeText = text => {
    this.setState({value: text});
  };
  render() {
    return (
      <View>
        <CustomTextInput customKeyboardType="hello" value={this.state.value} onChangeText={this.onChangeText} />
      </View>
    );
  }
}
```

## API

### register(type, type)

Register a custom keyboard type.

### install(tag, type)

Install custom keyboard to a `TextInput`.

Generally you can use CustomTextInput instead of this. But you can use this API
to install/change custom keyboard dynamically.

### uninstall(tag)

Uninstall custom keyboard from a `TextInput` dynamically.

### insertText(tag, text)

Use in a custom keyboard, insert text to `TextInput`.

### backSpace(tag)

Use in a custom keyboard, delete selected text or the charactor before cursor.

### doDelete(tag)

Use in a custom keyboard, delete selected text or the charactor after cursor.

### moveLeft(tag)

Use in a custom keyboard, move cursor to selection start or move cursor left.

### moveRight(tag)

Use in a custom keyboard, move cursor to selection end or move cursor right.

### switchSystemKeyboard(tag)

Use in a custom keyboard. Switch to system keyboard.

Next time user press or focus on the `TextInput`, custom keyboard will
appear again. To keep using system keyboard, call `uninstall` instead.

### CustomTextInput

Use instead of `TextInput`, this component support all properties of `TextInput`.

#### prop: customKeyboardType: string

Use a registered custom keyboard.
