//import 'package:find_officer_lra/Screens/Send.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ImageInput extends StatefulWidget {
  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File _imageFile;

  void _getImage(BuildContext context, ImageSource source){
    ImagePicker.pickImage(source: source, maxWidth: 400.0).then((File image){
      setState(() {
         _imageFile = image;
      });
      Navigator.pop(context);
    });
  }

  void _openImagePicker(BuildContext context) {
    showModalBottomSheet(context: context, builder: (BuildContext context){
      return Container(
        height: 150.0,
        padding: EdgeInsets.all(10.0), child: Column(
        children: <Widget>[
          Text('Pick an Image', style: TextStyle(fontWeight: FontWeight.bold),),
          SizedBox(height: 10.0,),
          FlatButton(
            textColor: Colors.black,
            child: Text('Use Camera'),
            onPressed: (){
              _getImage(context, ImageSource.camera);
              },
          ),
          FlatButton(
            textColor: Colors.black,
            child: Text('Use Gallery'),
            onPressed: (){
              _getImage(context, ImageSource.gallery);
            },
          )
        ],
      ),);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      OutlineButton(
        onPressed: (){
          _openImagePicker(context);
        },
        child: Row(children: <Widget>[
          Icon(Icons.camera_alt),
          SizedBox(width: 5.0,),
          Text('Add Evidence'),
        ],),),
      _imageFile == null ? Text('Please upload evidence.')
          : Image.file(
        _imageFile,
        fit: BoxFit.cover,
        height: 400.0,
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.center,
      ),
     // Send(file: _imageFile),
    ],);
  }
}
