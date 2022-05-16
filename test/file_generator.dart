import 'dart:io';

Future<void> main() async {
  //generate assets\\write\\category
  await assetWrite();
  //generate assets\\program
  await assetProgram();
  //generate assets\\video
  await assetVideo();
}
Future<void> assetWrite() async {
  //1. create rootDir (assets\\write)
  Directory dir = Directory("assets\\write");
  print(dir.path);

  //2. search the children dir of rootDir
  String category = "";
  await dir.list().toList().then((value) => {
    print(value),
    value.forEach((element) {
      var path = element.path;
      path = path.substring(path.lastIndexOf('\\')+1);
      category += path+'\n';
    })
  });

  //clear the content of indexDir (assets\\writeIndex)
  Directory indexDir = Directory("assets\\writeIndex");
  await indexDir.delete(recursive: true).then((value) => print(value)).catchError((err)=>{print(err)});
  await indexDir.create();

  //3. write down children dir in File (assets\\writeIndex\\writeCategory.txt)
  File file = File("assets\\writeIndex\\writeCategory.txt");
  file.writeAsString(category,mode: FileMode.write);
  await file.readAsString().then((value) => {
    print(value),
  });

  //4. search the children files of every chlid dir, do the same job
  List<String> categoryList = category.split('\n');
  categoryList.removeLast();
  print(categoryList);

  categoryList.forEach((element) async {

    Directory cateDir = Directory("assets\\write\\$element");

    String cateTitle = "";
    await cateDir.list().toList().then((value) => {
      value.forEach((_element) {
        var path = _element.path;
        path = path.substring(path.lastIndexOf('\\')+1);
        cateTitle += path+'\n';
      })
    });

    File file = File("assets\\writeIndex\\$element.txt");
    file.writeAsString(cateTitle,mode: FileMode.write);

  });
}
Future<void> assetProgram() async {
  //1. create rootDir (assets\\program)
  Directory dir = Directory("assets\\program");

  //2. search the children dir of rootDir
  String programIndex = "";
  await dir.list().toList().then((value) => {
    value.forEach((element) {
      var path = element.path;
      path = path.substring(path.lastIndexOf('\\')+1);
      programIndex += path+'\n';
    })
  });

  //3. write down children file in File (assets\\writeIndex\\writeCategory.txt)
  File file = File("assets\\programIndex\\programIndex.txt");
  file.writeAsString(programIndex,mode: FileMode.write);
  await file.readAsString().then((value) => {
    print(value),
  });

}
Future<void> assetVideo() async {
  //1. create rootDir (assets\\program)
  Directory dir = Directory("assets\\video");

  //2. search the children dir of rootDir
  String programIndex = "";
  await dir.list().toList().then((value) => {
    value.forEach((element) {
      var path = element.path;
      path = path.substring(path.lastIndexOf('\\')+1);
      programIndex += path+'\n';
    })
  });

  //3. write down children file in File (assets\\writeIndex\\writeCategory.txt)
  File file = File("assets\\videoIndex\\videoIndex.txt");
  file.writeAsString(programIndex,mode: FileMode.write);
  await file.readAsString().then((value) => {
    print(value),
  });

}