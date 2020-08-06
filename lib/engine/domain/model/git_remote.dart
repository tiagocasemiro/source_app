
class GitRemote {
  String name;
  String fetchUrl;
  String pushUrl;
  String _schemaPush;
  String _dotGitPush;
  
  GitRemote();

  String schemePush() {
    return _schemaPush != null ? _schemaPush : null;
  }

  String dotGitPush() {
    return _dotGitPush != null ? _dotGitPush : null;
  }

  bool hasPushUrl() {
    if(pushUrl != null && pushUrl.startsWith("http")) {
      List<String> parts = pushUrl.split("//");
      if(parts.length == 2) {
        _schemaPush = parts[0].trim();
        _dotGitPush = parts[1].trim();
      }      
    }

    return _schemaPush != null && _dotGitPush != null;
  }
}