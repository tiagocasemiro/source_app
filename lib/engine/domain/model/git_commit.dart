class GitCommit {
  String hash;
  String abbreviatedHash;
  String message;
  String date;
  String author;
  String beforeHash;
  List<Graph> graph;

  GitCommit({this.graph, this.abbreviatedHash = "", this.author = "", this.message = "", this.date = "", this.hash = "", this.beforeHash = ""});

  @override
  String toString() {
    return 'GitCommit{hash: $hash, abbreviatedHash: $abbreviatedHash, message: $message, date: $date, author: $author}';
  }
}

class Graph {
  String hash;
  bool right_to_up = false;
  bool right_from_down = false;
  bool right_to_right = false;
  bool left_to_left = false;
  bool left_to_up = false;
  bool left_from_down = false;
  bool commit = false;
  bool vertical = false;
  bool horizontal = false;
  bool cross = false;
  bool cross_commit = false;

  Graph({ this.hash });
}