class GitOutput {
  bool _isSuccess = true;
  String message;
  var object;

  GitOutput(this.message);

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

