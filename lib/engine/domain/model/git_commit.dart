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
  bool top_left = false;
  bool bottom_left = false;
  bool right_to_right = false;
  bool left_to_left = false;
  bool top_right = false;
  bool bottom_right = false;
  bool commit = false;
  bool end_commit = false;
  bool start_commit = false;
  bool vertical = false;
  bool horizontal = false;

  Graph({ this.hash });

  @override
  String toString() {
    return '$hash';
  }

  bool isEmpty() {
    return hash == null &&
      !top_left &&
      !bottom_left  &&
      !right_to_right  &&
      !left_to_left  &&
      !top_right  &&
      !bottom_right  &&
      !commit  &&
      !start_commit  &&
      !vertical  &&
      !horizontal;
  }

  bool onlyVertical() {
    return hash != null &&
      !top_left &&
      !bottom_left  &&
      !right_to_right  &&
      !left_to_left  &&
      !top_right  &&
      !bottom_right  &&
      !commit  &&
      !start_commit  &&
      !horizontal &&
      vertical;
  }
}