class TerminalOutput<T> {
  bool isSuccess = true;
  String message;
  T object;

  TerminalOutput failure(String terminalOutput) {
    this.isSuccess = false;
    this.message = terminalOutput;

    return this;
  }

  TerminalOutput success({T object}) {
    this.isSuccess = true;
    this.object = object;

    return this;
  }
}

