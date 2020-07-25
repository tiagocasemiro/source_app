class TerminalOutput {
  bool isSuccess = true;
  String message;
  var object;

  TerminalOutput(this.message);

  TerminalOutput failure() {
    this.isSuccess = false;

    return this;
  }

  TerminalOutput success({var object}) {
    this.isSuccess = true;
    this.object = object;

    return this;
  }

  @override
  String toString() {
    return 'TerminalOutput{isSuccess: $isSuccess, message: $message, object: $object}';
  }
}

