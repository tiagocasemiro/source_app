class GitOutput {
  bool _isSuccess = true;
  String message;
  var object;

  GitOutput(this.message);

  GitOutput failure() {
    this._isSuccess = false;

    return this;
  }

  GitOutput success({var object}) {
    this._isSuccess = true;
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

