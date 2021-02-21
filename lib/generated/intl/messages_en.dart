// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "login_err_empty" : MessageLookupByLibrary.simpleMessage("Username can\'t be empty"),
    "login_err_incorrect" : MessageLookupByLibrary.simpleMessage("User name or password incorrect"),
    "login_err_invalid_pwd" : MessageLookupByLibrary.simpleMessage("Invalid password"),
    "login_err_invalid_user" : MessageLookupByLibrary.simpleMessage("Invalid username"),
    "login_field_pwd" : MessageLookupByLibrary.simpleMessage("Password"),
    "login_field_user" : MessageLookupByLibrary.simpleMessage("Username"),
    "login_forgot" : MessageLookupByLibrary.simpleMessage("Forgot password?"),
    "login_help_user" : MessageLookupByLibrary.simpleMessage("Enter your username or email here"),
    "login_submit" : MessageLookupByLibrary.simpleMessage("Submit"),
    "login_try_login" : MessageLookupByLibrary.simpleMessage("Try to login"),
    "nav_add" : MessageLookupByLibrary.simpleMessage("Add"),
    "nav_games" : MessageLookupByLibrary.simpleMessage("Games"),
    "nav_last" : MessageLookupByLibrary.simpleMessage("Last file"),
    "nav_logout" : MessageLookupByLibrary.simpleMessage("Sing out"),
    "nav_options" : MessageLookupByLibrary.simpleMessage("Options")
  };
}
