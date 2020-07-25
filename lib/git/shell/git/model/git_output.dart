class GitOutput {
  bool isSuccess = true;
  String message;
  var object;

  GitOutput(this.message);

  GitOutput failure() {
    this.isSuccess = false;

    return this;
  }

  GitOutput success({var object}) {
    this.isSuccess = true;
    this.object = object;

    return this;
  }

  @override
  String toString() {
    return 'gitOutput{isSuccess: $isSuccess, message: $message, object: $object}';
  }
}

