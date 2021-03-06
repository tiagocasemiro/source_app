import 'dart:convert';

class GitOutput {
  bool _isSuccess = true;
  final String message;
  List<String> lines;
  var object;

  GitOutput(this.message) {
    lines = LineSplitter().convert(message);
  }

  GitOutput failure() {
    this._isSuccess = false;

    return this;
  }

  GitOutput success() {
    this._isSuccess = true;
    return this;
  }

  GitOutput withObject(var object) {
    this.object = object;

    return this;
  }

  bool isFailure() {
    return !_isSuccess;
  }

  bool isSuccess() {
    return _isSuccess;
  }

  @override
  String toString() {
    return 'gitOutput{isSuccess: $_isSuccess, message: $message, object: $object}';
  }
}

