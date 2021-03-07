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
  // ignore: non_constant_identifier_names
  bool top_left = false;
  String hash;
  // ignore: non_constant_identifier_names
  bool top_right = false;
  // ignore: non_constant_identifier_names
  bool bottom_left = false;
  // ignore: non_constant_identifier_names
  bool right_to_right = false;
  // ignore: non_constant_identifier_names
  bool left_to_left = false;
  // ignore: non_constant_identifier_names
  bool bottom_right = false;
  bool commit = false;
  // ignore: non_constant_identifier_names
  bool end_commit = false;
  // ignore: non_constant_identifier_names
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