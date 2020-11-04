class GitCommit {
  String asciiGraph;
  String hash;
  String abbreviatedHash;
  String message;
  String date;
  String author;
  String beforeHash;
  GraphHelper graphHelper;

  GitCommit({this.asciiGraph = "", this.abbreviatedHash = "", this.author = "", this.message = "", this.date = "", this.hash = "", this.beforeHash = ""});

  @override
  String toString() {
    return 'GitCommit{asciiGraph: $asciiGraph, hash: $hash, abbreviatedHash: $abbreviatedHash, message: $message, date: $date, author: $author}';
  }
}

class GraphHelper {
  bool right_to_up = false;
  bool right_from_down = false;
  bool left_to_up = false;
  bool left_from_down = false;
  bool right_to_right = false;
  bool left_to_left = false;
  bool commit = false;
  bool vertical = false;
  bool horizontal = false;
  bool cross = false;
  bool cross_commit = false;
}