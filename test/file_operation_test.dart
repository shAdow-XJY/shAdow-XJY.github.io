import 'dart:io';

Future<void> main() async {

  await DirectoryCreate();

}
Future<void> DirectoryCreate() async {
  //1. create rootDir
  for(var i = 1; i <= 144; ){
    Directory dir = Directory("E:\\Epic Games Unreal Projects\\Animation_Base\\Content\\MocapCMU\\MocapCMU-InPlace\\MocapCMU_${i.toString()}_${(i+12).toString()}");
    if(!dir.existsSync()){
      dir.create();
      print(dir.path);
    }
    i += 12;
  }

}
