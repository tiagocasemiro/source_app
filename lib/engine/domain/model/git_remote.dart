
class GitRemote {
  String name;
  String url;

  String urlWithCredentials(String username, String password) {
    if(url != null && url.isNotEmpty) {
      List<String> parts = url.split("//");
      if(parts.length == 2) {
        if(parts[1].contains("@")) {
          List<String> identifier = parts[1].split("@");
          return parts[0].trim() + "//" + username + ":" + password + "@" + identifier[1].trim();
        } else {
          return parts[0].trim() + "//" + username + ":" + password + "@" + parts[1].trim();
        }
      }      
    }

    return null;
  }
}