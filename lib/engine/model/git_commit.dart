class GitCommit {
  String asciiGraph;
  String hash;
  String abbreviatedHash;
  String message;
  String date;
  String author;

  GitCommit({this.asciiGraph = "", this.abbreviatedHash = "", this.author = "", this.message = "", this.date = ""});

  @override
  String toString() {
    return 'GitCommit{asciiGraph: $asciiGraph, hash: $hash, abbreviatedHash: $abbreviatedHash, message: $message, date: $date, author: $author}';
  }
}
