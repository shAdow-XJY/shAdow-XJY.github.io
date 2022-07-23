import 'dart:io';

Future<void> main() async {
  Set set = {};
  set.addAll(['a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z']);
  set.addAll(['A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z']);
  var list = await assetDir('write');
  var list2 = await assetDir('program');
  var list3 = await assetDir('videoIndex');
  var list4 = await rootFile(['lib','indexPage','indexHome','indexHome.dart']);
  var list5 = await rootFile(['lib','indexPage','indexFavorite','indexFavorite.dart']);
  set.addAll(list);
  set.addAll(list2);
  set.addAll(list3);
  set.addAll(list4);
  set.addAll(list5);
  File file = File("local\\fonts\\fontcontent.txt");
  if(!file.existsSync()){
    file.create();
  }
  await file.writeAsString(set.toString(),mode: FileMode.write);
}
Future<List> assetDir(String dirname) async {
  Set writeSet = {};
  // writeSet.addAll([1,'d',5]);
  // print(writeSet);

  //1. create rootDir (assets\\write)
  Directory dir = Directory("assets\\$dirname");

  //2. search the recursive children dir/file names of rootDir
  var fileList = await dir.list(recursive: true).toList();
  var FileList = [];
  fileList.forEach((element) {
    writeSet.addAll(element.path.split(''));
    if(element.runtimeType.toString() == '_File'){
      FileList.add(element);
    }
  });

  //read the content of files
  for(var i=0; i<FileList.length; i++){
    File file = File(FileList[i].path);
    var temp = await file.readAsString();
    writeSet.addAll(temp.split(''));
  }

  return writeSet.toList();
}

Future<List> rootFile(List<String> filePath) async {
  Set writeSet = {};
  File file = File(filePath.join("\\"));
  var temp = await file.readAsString();
  writeSet.addAll(temp.split(''));
  return writeSet.toList();
}