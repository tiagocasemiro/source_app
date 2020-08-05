
class GitRemote {
  String name;
  String fetchUrl;
  String pushUrl;
  String _schemaPush;
  String _hostPush;
  String _pathGitPush;
  
  GitRemote();

  String hostPush() {
    return _schemaPush != null && _hostPush != null ? _schemaPush  + "//" + _hostPush : null;
  }

  String pathGitPush() {
    return _pathGitPush != null ? _pathGitPush : null;
  }

  bool hasPushUrl() {
    if(pushUrl != null && pushUrl.startsWith("http")) {
      List<String> parts = pushUrl.split("//");
      if(parts.length > 1) {
        _schemaPush = parts[0];
        List<String> parts2 = parts[1].split("/");
        if(parts2.length > 1) {
          _hostPush = parts2[0];
          _pathGitPush = parts2[0];
        }
      }
    }

    return _schemaPush != null && _hostPush != null && _pathGitPush != null;
  }
}