
class GitRemote {
  String name;
  String url;

  String urlWithCredentials(String username, String password) {
    if(url != null && url.isNotEmpty) {
      List<String> parts = url.split("//");
      if(parts.length == 2) {
        return parts[0].trim() + "//" + username + ":" + password + "@" + parts[1].trim();
      }      
    }

    return null;
  }
}