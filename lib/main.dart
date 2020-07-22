
import 'package:flutter/material.dart';


void main() {
  runApp(SourceApp());

  //Git().add().files(["document_1.txt"]).then((branches) => print(branches));
  //Git().commit("linha 9 passo a passo").then((branches) => print(branches));
  //Git().push("tiagocasemiro", "password").then((branches) => print(branches));
  //Git().add().all().call().then((value) => print(value));

}

/*Future<void> main() async {
  print('Current directory: ${p.current}');

  if (await GitDir.isGitDir(p.current)) {
    final gitDir = await GitDir.fromExisting(p.current);
    final commitCount = await gitDir.commitCount();
    print('Git commit count: $commitCount');
  } else {
    print('Not a Git directory');
  }
}*/

class SourceApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Source',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Container(
        color: Colors.white,
      ),
    );
  }
}
