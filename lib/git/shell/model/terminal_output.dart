
class TerminalOutput {
  int _successExitCode = 0;
  String message;
  int exitCode;

  TerminalOutput(this.message, this.exitCode);

  bool isSuccess() {
    return exitCode == _successExitCode;
  }

  bool isFailure() {
    return exitCode != _successExitCode;
  }

  @override
  String toString() {
    return 'TerminalOutput{message: $message, exitCode: $exitCode}';
  }
}