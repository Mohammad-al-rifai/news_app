  import 'package:flutter/material.dart';
  import 'dart:io';
  import 'package:image_picker/image_picker.dart';
  import 'package:http/http.dart' as http;
  import 'dart:convert';



class ImagePickerScreen extends StatefulWidget {

  @override
  _ImagePickerScreenState createState() => _ImagePickerScreenState();
}

class _ImagePickerScreenState extends State<ImagePickerScreen> {

  File file;

  Future pickerCamera()async{
    final myFile = await ImagePicker().getImage(source: ImageSource.camera);
    setState(() {
      file = File(myFile.path);
      print("FileImage: "+file.toString());
    });
  }

  Future upload()async{
    if(file == null) return;
    String base64 = base64Encode(file.readAsBytesSync());
    String imageName = file.path.split('/').last;
    print("base64Image Is: "+base64);
    print("Image Saved On File:"+ file.toString());
    print("ImageName Is :"+imageName);

    var url = "http://10.0.2.2:8000/api/uploadImage.php";
    var data = {"imageName":imageName,"image64":base64};
    var response = await http.post(Uri.parse(url),body: data);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Image'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              RaisedButton(
                child: Text('Get Image'),
                  onPressed: (){
                pickerCamera();
              }),
              SizedBox(height: 40.0,),
              file == null? Text('Image Not Selected Yet!'): Image.file(file),
              RaisedButton(
                  child: Text('Upload Image'),
                  onPressed: (){
                    upload();
                  }),
            ],
          )
        ),
      ),
    );
  }
}


/*
* Flutter Upload Image:
*   1. var type File
*   2. image Picker (Camera Or Gallery) Async Await
*   3. base64Encode (file.readAsBytesSync()); // Type String image64
*   4. file.path.split("/").last // Type String image
*   5. Send To PHP File "base64Image":base64Image, "image":fileName
* */
