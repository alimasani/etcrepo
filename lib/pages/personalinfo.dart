import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:path/path.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:etc/bloc/bloc.dart';
import 'package:etc/components/emailform.dart';
import 'package:etc/components/notauthorized.dart';
import 'package:etc/helper/globals.dart';
import 'package:etc/helper/methods.dart';
import 'package:etc/helper/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PersonalInfo extends StatefulWidget {
  PersonalInfo({Key key}) : super(key: key);

  @override
  _PersonalInfoState createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> {
  final _fnameController = TextEditingController();
  final _lnameController = TextEditingController();
  bool _processing = false;
  bool _activeEmailBtn = false;
  String userName = "";
  bool _uploadingImage = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  _selectImage(typ,context) async {
    Navigator.of(context).pop();
    _uploadingImage = true;
    setState(() {});
    
    String _baseUrl= HelperMethods().searchArray(baseURL, "mode", appMode)['url'];
    String url = authWeb + apiV1 + 'uploadPhoto';

    try {
      File _imageFile = await ImagePicker.pickImage(
        source: (typ=="gallery")?ImageSource.gallery: ImageSource.camera,
        imageQuality: 60,
        maxHeight: 500,
        maxWidth: 500
        );

      var prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('authToken');

      Map<String, String> headers = {};
      headers['authorization'] = token;
      print(headers);
      final mimeTypeData =
          lookupMimeType(_imageFile.path, headerBytes: [0xFF, 0xD8]).split('/');

      final imageUploadRequest =
          http.MultipartRequest('POST', Uri.parse(_baseUrl + url),);
      final file = await http.MultipartFile.fromPath('file', _imageFile.path,
          contentType: MediaType(mimeTypeData[0], mimeTypeData[1]));
      
      imageUploadRequest.headers.addAll(headers);
      imageUploadRequest.fields['ext'] = mimeTypeData[1];
      imageUploadRequest.files.add(file);
    
      try {
        final streamedResponse = await imageUploadRequest.send();
        final response = await http.Response.fromStream(streamedResponse);
        print("success");
        print(response);
        _uploadingImage = false;
        setState(() {});
        if (response.statusCode != 200) {
          Scaffold.of(context).showSnackBar(SnackBar(
            behavior: SnackBarBehavior.floating,
            content: Text(
              "Image upload failed. Please try again later.",
              textAlign: TextAlign.center,
            ),
            backgroundColor: Colors.red,
          ));
          return null;
        }
        BlocProvider.of<AuthenticateBloc>(context).add(
          AppStarted()
        );
        Scaffold.of(context).showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text(
          "Image successfully uploaded.",
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.green,
      ));
        final Map<String, dynamic> responseData = json.decode(response.body);
        print(responseData);
        return responseData;
      } catch (e) {
        print(e);
        _uploadingImage = false;
        setState(() {});
        Scaffold.of(context).showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text(
          "Image upload failed. Please try again later.",
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.red,
      ));
        return null;

      }

    }catch (e){
      _uploadingImage = false;
      setState(() {});
      Scaffold.of(context).showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text(
          "Image upload failed. Please try again later.",
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.red,
      ));
    }
  }

  // _selectImage(typ, context) async {
  //   Navigator.of(context).pop();
  //   _uploadingImage = true;
  //   setState((){});
  //   try {
  //     File _imageFile = await ImagePicker.pickImage(
  //         source: (typ == 'gallery') ? ImageSource.gallery : ImageSource.camera,
  //         imageQuality: 60,
  //         maxHeight: 500,
  //         maxWidth: 500);

  //     FormData data = FormData.fromMap({
  //       "file": await MultipartFile.fromFile(_imageFile.path,
  //           filename: "userImage.jpg"), //_imageFile.path.split("/").last
  //     });

  //     // FormData data = FormData.fromMap({
  //     //   "file":_imageFile.path
  //     // });
  //     // data.files.add(MapEntry("file", await MultipartFile.fromFile(_imageFile.path, filename: "pic-name.png"), ));
  //     // data.files.add(MapEntry("file", _imageFile.path));

  //     var resp = await Services().uploadImage(data: data);
  //     print(resp);

  //     _uploadingImage = false;
  //     setState((){});
  //   } catch (e) {
  //     print(e);
  //     _uploadingImage = false;
  //     setState((){});
      // Scaffold.of(context).showSnackBar(SnackBar(
      //   behavior: SnackBarBehavior.floating,
      //   content: Text(
      //     "Image upload failed. Please try again later.",
      //     textAlign: TextAlign.center,
      //   ),
      //   backgroundColor: Colors.red,
      // ));
  //   }
  // }

  _update(context) async {
    if (_fnameController.text == '' || _fnameController == null) {
      Scaffold.of(context).showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text(
          "Please enter valid first name",
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.red,
      ));
      return false;
    }

    if (_lnameController.text == '' || _lnameController == null) {
      Scaffold.of(context).showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text(
          "Please enter valid last name",
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.red,
      ));
      return false;
    }

    try {
      var data = {};
      data['firstName'] = _fnameController.text;
      data['lastName'] = _lnameController.text;
      var resp = await Services().updateName(data: data);
      Scaffold.of(context).showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text(
          "Profile updated successfully.",
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.greenAccent,
      ));
      return false;
    } catch (e) {
      print(e);
      if (_lnameController.text == '' || _lnameController == null) {
        Scaffold.of(context).showSnackBar(SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text(
            "Error occured while updating your profile.",
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.red,
        ));
        return false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
          appBar: AppBar(title: Text("Personal Info"), centerTitle: true),
          body: BlocBuilder<AuthenticateBloc, AuthenticateState>(
            builder: (context, state) {
              if (state is AuthenticateSuccess) {
                final profile = state.profile;
                userName = profile['userProfile']['userName'];
                _fnameController.text = profile['userProfile']['firstName'];
                _lnameController.text = profile['userProfile']['lastName'];
                return SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                      Container(
                        padding: EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 30.0),
                        child: Center(
                          child: InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (builder) {
                                    return Container(
                                      height: 150.0,
                                      padding: EdgeInsets.all(16.0),
                                      child: Column(children: <Widget>[
                                        InkWell(
                                          onTap: () {
                                            _selectImage("camera", context);
                                          },
                                          child: Container(
                                            padding:
                                                EdgeInsets.only(bottom: 10.0),
                                            decoration: BoxDecoration(
                                                border: Border(
                                                    bottom: BorderSide(
                                                        color:
                                                            Colors.black12))),
                                            child: Row(
                                              children: <Widget>[
                                                Icon(
                                                  Icons.photo_camera,
                                                  color: grayColor,
                                                ),
                                                SizedBox(
                                                  width: 5.0,
                                                ),
                                                Text(
                                                  "Select from Camera",
                                                  style:
                                                      TextStyle(fontSize: 16.0),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            _selectImage("gallery", context);
                                          },
                                          child: Container(
                                            padding: EdgeInsets.only(
                                                bottom: 10.0, top: 10.0),
                                            decoration: BoxDecoration(
                                                border: Border(
                                                    bottom: BorderSide(
                                                        color:
                                                            Colors.black12))),
                                            child: Row(
                                              children: <Widget>[
                                                Icon(
                                                  Icons.photo,
                                                  color: grayColor,
                                                ),
                                                SizedBox(
                                                  width: 5.0,
                                                ),
                                                Text(
                                                  "Select from Gallery",
                                                  style:
                                                      TextStyle(fontSize: 16.0),
                                                )
                                              ],
                                            ),
                                          ),
                                        )
                                      ]),
                                    );
                                  });
                            },
                            child: Stack(
                              children: <Widget>[
                                Container(
                                  child: CachedNetworkImage(
                                    imageUrl: profile['userProfile']
                                        ['linkReferences'][0]['link'],
                                    fit: BoxFit.fitWidth,
                                    width: 150,
                                    height: 150,
                                  ),
                                ),
                                Container(
                                  child: Positioned(
                                      right: 0,
                                      top: 0,
                                      child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.black45,
                                              shape: BoxShape.circle),
                                          padding: EdgeInsets.all(3.0),
                                          child: Icon(
                                            Icons.edit,
                                            color: Colors.white,
                                            size: 18.0,
                                          ))),
                                ),
                                if (_uploadingImage==true) Container(
                                  child:Positioned(
                                    top:0,
                                    left:0,
                                    width:150,
                                    height:150,
                                    child: Container(color:Colors.white38,child:Center(child: CircularProgressIndicator(strokeWidth: 1.5,),),),
                                  )
                                )
                              ],
                            ),
                          ),
                        ),
                        color: primaryColor,
                      ),
                      Container(
                        padding: EdgeInsets.all(17.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Container(
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Colors.black12))),
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: TextFormField(
                                            controller: _fnameController,
                                            textInputAction:
                                                TextInputAction.next,
                                            keyboardType:
                                                TextInputType.emailAddress,
                                            autocorrect: false,
                                            onChanged: (value) {},
                                            decoration: InputDecoration(
                                                isDense: true,
                                                contentPadding:
                                                    EdgeInsets.all(12),
                                                hintText: "First Name",
                                                hintStyle:
                                                    TextStyle(color: grayColor),
                                                fillColor: Colors.white,
                                                filled: false,
                                                enabledBorder: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.0),
                                                    borderSide: BorderSide(
                                                        color:
                                                            Colors.transparent,
                                                        width: 1.0)),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5.0),
                                                        borderSide:
                                                            BorderSide.none))),
                                      )
                                    ],
                                  )),
                              Container(
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Colors.black12))),
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: TextFormField(
                                            controller: _lnameController,
                                            textInputAction:
                                                TextInputAction.next,
                                            keyboardType:
                                                TextInputType.emailAddress,
                                            autocorrect: false,
                                            onChanged: (value) {},
                                            decoration: InputDecoration(
                                                isDense: true,
                                                contentPadding:
                                                    EdgeInsets.all(12),
                                                hintText: "Last Name",
                                                hintStyle:
                                                    TextStyle(color: grayColor),
                                                fillColor: Colors.white,
                                                filled: false,
                                                enabledBorder: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.0),
                                                    borderSide: BorderSide(
                                                        color:
                                                            Colors.transparent,
                                                        width: 1.0)),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5.0),
                                                        borderSide:
                                                            BorderSide.none))),
                                      )
                                    ],
                                  )),
                              Container(
                                child: FlatButton(
                                  color: primaryColor,
                                  disabledColor: Colors.grey,
                                  disabledTextColor: Colors.black,
                                  onPressed: (_processing == false)
                                      ? () {
                                          _update(context);
                                        }
                                      : null,
                                  child: Container(
                                      padding: EdgeInsets.fromLTRB(
                                          0.0, 12.0, 0.0, 12.0),
                                      child: Text(
                                        (_processing == true)
                                            ? "Processing"
                                            : "Update".toUpperCase(),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16.0,
                                            height: 1.2,
                                            fontWeight: FontWeight.w600),
                                      )),
                                ),
                              ),
                            ]),
                      ),
                      Divider(
                        color: Colors.black26,
                      ),
                      Container(
                        padding: EdgeInsets.all(17.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Container(
                                  padding: EdgeInsets.only(
                                      top: 12, left: 12, bottom: 12, right: 0),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Colors.black12))),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.of(context).pushNamed(
                                          '/changeEmail',
                                          arguments: {"type": "email","userName":profile['userProfile']['userName']});
                                    },
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Text(
                                            profile['userProfile']
                                                ['primaryEmail'],
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                color: Colors.blueAccent),
                                          ),
                                        ),
                                        // Text(
                                        //   "Change",
                                        //   style: TextStyle(
                                        //     color: blueColor,
                                        //     fontSize: 14.0,
                                        //     fontWeight: FontWeight.w600,
                                        //   ),
                                        // )
                                      ],
                                    ),
                                  )),
                              Container(
                                  padding: EdgeInsets.only(
                                      top: 12, left: 12, bottom: 12, right: 0),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Colors.black12))),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.of(context).pushNamed(
                                          '/changeEmail',
                                          arguments: {"type": "mobile","userName":profile['userProfile']['userName']});
                                    },
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Text(
                                            profile['userProfile']
                                                ['primaryMobile'],
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                color: Colors.blueAccent),
                                          ),
                                        )
                                      ],
                                    ),
                                  )),
                              Container(
                                  padding: EdgeInsets.only(
                                      top: 12, left: 12, bottom: 12, right: 0),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Colors.black12))),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.of(context).pushNamed(
                                          '/changePass',
                                          arguments: {"userName": userName});
                                    },
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Text(
                                            "Change Password",
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                color: Colors.blueAccent),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
                            ]),
                      )
                    ]));
              } else {
                return NotAuthorized();
              }
            },
          )),
    );
  }
}
