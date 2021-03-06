import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:team_gp/Model/category.dart';
import 'package:image_picker/image_picker.dart';
import 'package:team_gp/Screens/Services/categ.dart';
import 'package:path/path.dart' as p;
import 'package:team_gp/Screens/Widget/button.dart';

class CustomDialog extends StatefulWidget {
  @override
  _CustomDialogState createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  final _store = StoreCategory();
  String _imageURL;
  String _name;
  File _image;

  @override
  Widget _showImage() {
    return CircleAvatar(
      backgroundImage: _image == null ? null : FileImage(_image),
      backgroundColor: Colors.blueGrey[100],
      radius: 60,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  Widget dialogContent(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 0.0, right: 0.0),
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
              top: 60.0,
            ),
            margin: EdgeInsets.only(top: 13.0, right: 8.0),
            decoration: BoxDecoration(
                color: Colors.blueGrey[50],
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 0.0,
                    offset: Offset(0.0, 0.0),
                  ),
                ]),
            child: SingleChildScrollView(
              child: Form(
                key: _formkey,
                autovalidate: true,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  //crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    _showImage(),
                    SizedBox(
                      height: 10.0,
                    ),
                    //???? ???????????? ???????? ?????????? ?????? ???????????? ???? ??????????????
                    GestureDetector(
                        onTap: takeImage,
                        child: Container(
                            margin: EdgeInsets.all(0),
                            padding: EdgeInsets.all(2),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Colors.blue[50],
                                border: Border.all(
                                    width: 1, color: Colors.blueGrey[200])),
                            child: Icon(
                              Icons.add_photo_alternate_rounded,
                              color: Colors.blueGrey[500],
                              size: 30,
                            ))),
                    // ???? ???????????? ???????? ?????????? ????????????
                    GestureDetector(
                        onTap: () {
                          uploadImage(context);
                        },
                        child: Container(
                            margin: EdgeInsets.all(0),
                            padding: EdgeInsets.all(2),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Colors.blue[50],
                                border: Border.all(
                                    width: 1, color: Colors.blueGrey[200])),
                            child: Icon(
                              Icons.check_circle,
                              color: Colors.blueGrey[500],
                              size: 30,
                            ))),
                    SizedBox(
                      height: 10,
                    ),
                    // ?????????????? ???????? ???????? ??????????
                    TextFormField(
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Name is required';
                        }
                        return null;
                      },
                      onSaved: (String value) {
                        _name = value;
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.9),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide(
                              color: Colors.blueGrey[200],
                            )),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide(
                              color: Colors.blueGrey[200],
                            )),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide(
                              color: Colors.blueGrey[200],
                            )),
                        labelText: "Name",
                      ),
                      keyboardType: TextInputType.text,
                    ),
                    // ?????? ???????????? ??????
                    SizedBox(height: 15.0),
                    // ????????????
                    /* Builder(
                          builder: (context)=> InkWell(
                          child: Container(
                            width: 80,
                              padding: EdgeInsets.only(top: 15.0,bottom:15.0),
                              decoration: BoxDecoration(
                              color:Colors.deepOrange[300],
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(16.0),
                                  topRight: Radius.circular(16.0),
                                  bottomLeft: Radius.circular(16.0),
                                  bottomRight: Radius.circular(16.0)),
                              ),
                              child:  Text(
                              "Add",
                              style: TextStyle(color: Colors.white,fontSize: 20.0),
                              textAlign: TextAlign.center,
                              ),
                          ),
                          onTap:(){
                            uploadImage(context);
                             if(_formkey.currentState.validate()){
                               //  uploadImage(context);
                                _formkey.currentState.save();
                                //_formkey.currentState.reset();
                                _store.addCategory(Category(
                                 name: _name,
                                 image: _imageURL,
                                ));
                              }
                          },
                          ),
                        ),*/
                    GradientButton(
                      width: 109,
                      height: 50,
                      onPressed: () {
                        uploadImage(context);
                        if (_formkey.currentState.validate()) {
                          //  uploadImage(context);
                          _formkey.currentState.save();
                          //_formkey.currentState.reset();
                          _store.addCategory(Category(
                            name: _name,
                            image: _imageURL,
                          ));
                        }
                      },
                      text: Text(
                        "Add",
                        style: TextStyle(color: Colors.white, fontSize: 20.0),
                        textAlign: TextAlign.center,
                      ),
                      icon: Icon(null),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
          // close ???? ????
          Positioned(
            right: 0.0,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Align(
                alignment: Alignment.topRight,
                child: CircleAvatar(
                  radius: 14.0,
                  backgroundColor: Colors.red[400],
                  child: Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ???? ?????? ???????????? ?????????? ???????????? ???? ???????????????? ???????????? ???? ???????????? ???? ???????? ???????????? ?????????? ????????
  void pickImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = image;
    });
  } // ???????????????? ???????? ??????

  // ???? ???????????????? ???????? ?????????? ?????????? ???? ??????????????
  void takeImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }
///////////////////
  /*Widget _decideImageView()
  {
    if(_image != null){
      return Image.file(_image);
    }else
    return Text("No Image Selected");
  }*/

/////// ???????????????? ???????? ?????????? ?????????? ???? ????????????????
  void uploadImage(context) async {
    try {
      FirebaseStorage storage =
          FirebaseStorage.instanceFor(bucket: 'gs://review-77112.appspot.com');
      Reference ref = storage.ref().child(p.basename(_image.path));
      UploadTask storageUploadTask = ref.putFile(_image);
      TaskSnapshot taskSnapshot =
          await storageUploadTask.whenComplete(() => null);
      /*Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('success'),
      ));*/
      String url = await taskSnapshot.ref.getDownloadURL();
      //String url = link.toString();
      print('url $url');
      setState(() {
        _imageURL = url;
      });
    } catch (ex) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(ex.message),
      ));
    }
  }
// ???????????????? ???????? ??????
}
