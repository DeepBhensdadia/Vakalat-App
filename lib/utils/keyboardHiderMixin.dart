import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

/// Mixin that enables hiding the keyboard easily upon any interaction or logic
/// from any class.
abstract class KeyboardHiderMixin {
  void hideKeyboard({
    BuildContext? context,
    bool hideTextInput = true,
    bool requestFocusNode = true,
  }) {
    if (hideTextInput) {
      SystemChannels.textInput.invokeMethod('TextInput.hide');
    }
    if (context != null && requestFocusNode) {
      FocusScope.of(context).requestFocus(FocusNode());
    }
  }
}

/// A widget that can be used to hide the text input that are opened by text
/// fields automatically on tap.
///
/// Delegates to [KeyboardHiderMixin] for hiding the keyboard on tap.
class KeyboardHider extends StatelessWidget with KeyboardHiderMixin {
  final Widget child;

  /// Decide whether to use
  /// `SystemChannels.textInput.invokeMethod('TextInput.hide');`
  /// to hide the keyboard
  final bool hideTextInput;
  final bool requestFocusNode;

  /// One of hideTextInput or requestFocusNode must be true, otherwise using the
  /// widget is pointless as it will not even try to hide the keyboard.
  KeyboardHider({super.key, 
    required this.child,
    this.hideTextInput = true,
    this.requestFocusNode = true,
  })  : assert(hideTextInput || requestFocusNode);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        hideKeyboard(
          context: context,
          hideTextInput: hideTextInput,
          requestFocusNode: requestFocusNode,
        );
      },
      child: child,
    );
  }
}
