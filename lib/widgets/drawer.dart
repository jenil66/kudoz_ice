import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path/path.dart' as Path;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kudoz_ice/reg_login/splash_screen.dart';
import 'package:provider/provider.dart';
import '../model/usermodel.dart';
import '../order/my_order_list.dart';
import '../pages/ContactPage.dart';
import '../cart/cart.dart';
import '../pages/home_screen.dart';
import '../pages/wishlist.dart';
import '../provider/cart_provider.dart';
import '../route/routing_page.dart';
import 'dimesial.dart';

class drawer extends StatefulWidget {
  const drawer({Key? key}) : super(key: key);

  @override
  State<drawer> createState() => _drawerState();
}

class _drawerState extends State<drawer> {
  File? image;
  bool imageLoaded = false;

  Future<String> uploadImage(File image) async {
    String fileName = Path.basename(image.path);
    Reference firebaseStorageRef =
    FirebaseStorage.instance.ref().child('userimage_$fileName.png');
    UploadTask uploadTask = firebaseStorageRef.putFile(image);
    TaskSnapshot taskSnapshot = await uploadTask;
    if (taskSnapshot.state == TaskState.success) {
      String downloadUrl = await taskSnapshot.ref.getDownloadURL();
      // downloadUrl = await (await uploadTask).ref.getDownloadURL();
      return downloadUrl;
    }
    throw Exception('Failed to upload image');
  }

  Future<void> saveImage(File imageFile) async {
    String imageUrl = await uploadImage(imageFile);
    FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({"imageUrl": imageUrl});
  }

  Future<void> _deleteImage() async {
    setState(() {
      image = null;
    });
    FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({"imageUrl": null});
  }

  Future<void> pickImage(ImageSource source) async {
    final pickedImage = await ImagePicker().pickImage(source: source);
    if (pickedImage != null) {
      final pickedImageFile = File(pickedImage.path);
      setState(() {
        image = pickedImageFile;
      });
      saveImage(pickedImageFile);
      print(pickedImageFile);
    }
  }

  UserModel? userModel;

  Future<void> getCurrentUserData() async {
    final docSnapshot = await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    if (docSnapshot.exists) {
      setState(() {
        userModel = UserModel.fromDocument(docSnapshot);
        if (userModel!.user_image!.isNotEmpty) {
          if (userModel!.user_image != null) {
            imageLoaded = false;
            NetworkImage(userModel!.user_image!).resolve(ImageConfiguration()).addListener(
              ImageStreamListener((_, __) {
                setState(() {
                  imageLoaded = true;
                });
              }),
            );
          }
        }
      });
    } else {
      print("Document Does Not Exist");
    }
  }





  @override
  void initState() {
    super.initState();
    getCurrentUserData();
  }


  @override
  Widget build(BuildContext context) {
    if (userModel == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    Cartprovider cartprovider = Provider.of<Cartprovider>(context);
    cartprovider.getcartData();

    return Drawer(
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.only(topRight: Radius.circular(Dimensions.h50),bottomRight: Radius.circular(Dimensions.h50)),
        borderSide: BorderSide.none,
      ),
      backgroundColor: Colors.white,
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.grey[350]
            ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: Dimensions.r50,
                        backgroundColor: Colors.white,
                        child: ClipOval(
                          child: userModel!.user_image== ""
                              ? Icon(
                            Icons.person,
                            size: 90,
                            color: Colors.black54,
                          )
                              : imageLoaded
                                ? userModel!.user_image!.isNotEmpty?Image.network(userModel!.user_image!,height: Dimensions.h170,
                            width: Dimensions.h170,
                            fit: BoxFit.cover,):CircularProgressIndicator(color: Colors.black,)
                                : CircularProgressIndicator(color: Colors.black,),
                          // Image.network(
                          //   "${getimage()}",
                          //   height: Dimensions.h170,
                          //   width: Dimensions.h170,
                          //   fit: BoxFit.cover,
                          // ),
                        ),
                      ),
                      Positioned(
                        bottom: 1,
                        right: -14.5,
                        child: IconButton(
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(Dimensions.h20),
                                ),
                              ),
                              builder: (context) {
                                return Container(
                                  height: Dimensions.h170,
                                  width: double.infinity,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: Dimensions.w20,
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "Profile Photo",
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500,
                                                fontSize: Dimensions.h25,
                                              ),
                                            ),
                                            Spacer(),
                                            InkWell(
                                              onTap: () {
                                                Navigator.pop(context);
                                                if(userModel!.user_image==""){
                                                  setState(() {
                                                    Fluttertoast.showToast(
                                                        msg: "Profile Photo Not Found",
                                                        toastLength: Toast.LENGTH_SHORT);
                                                  });
                                                }
                                                else{

                                                  FirebaseFirestore.instance
                                                      .collection("users")
                                                      .doc(FirebaseAuth.instance.currentUser!.uid)
                                                      .update({"User_image": "",});
                                                }
                                                Navigator.pop(context);
                                              },
                                              child: Icon(
                                                Icons.delete,
                                                color: Colors.grey,
                                                size: Dimensions.w25,
                                              ),
                                            )
                                          ],
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                              children: [
                                                InkWell(
                                                  onTap: () async {
                                                    Navigator.pop(context);
                                                    Navigator.pop(context);
                                                    ImagePicker picker = ImagePicker();
                                                    XFile? file = await picker.pickImage(source: ImageSource.camera);
                                                    if (file == null) return;

                                                    String uniqueFilename = FirebaseAuth.instance.currentUser!.uid;
                                                    Reference reference = FirebaseStorage.instance.ref();
                                                    Reference refImg = reference.child("user_profile_photos");
                                                    Reference refUploadImage = refImg.child(uniqueFilename);

                                                    try {
                                                      await refUploadImage.putFile(File(file.path));
                                                      String imageUrl = await refUploadImage.getDownloadURL();
                                                      print('Image URL: $imageUrl');

                                                      await FirebaseFirestore.instance
                                                          .collection("users")
                                                          .doc(FirebaseAuth.instance.currentUser!.uid)
                                                          .update({"User_image": imageUrl,});
                                                      print('User data updated successfully');

                                                    } catch (e) {
                                                      print('Error updating user data: $e');
                                                    }
                                                  },
                                                  child: CircleAvatar(
                                                    radius: Dimensions.r20 +
                                                        Dimensions.r20,
                                                    backgroundColor:
                                                    Colors.grey.shade200,
                                                    child: Icon(
                                                      Icons.camera_alt,
                                                      color: Colors.grey,
                                                      size: Dimensions.h35,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: Dimensions.h10,
                                                ),
                                                Text(
                                                  "Camera",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                      FontWeight.w500,
                                                      fontSize: Dimensions.h18),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              width: Dimensions.w50,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                              children: [
                                                InkWell(
                                                  onTap: () async {
                                                    Navigator.pop(context);
                                                    Navigator.pop(context);
                                                    ImagePicker picker = ImagePicker();
                                                    XFile? file = await picker.pickImage(source: ImageSource.gallery);
                                                    if (file == null) return;

                                                    String uniqueFilename = FirebaseAuth.instance.currentUser!.uid;
                                                    Reference reference = FirebaseStorage.instance.ref();
                                                    Reference refImg = reference.child("user_profile_photos");
                                                    Reference refUploadImage = refImg.child(uniqueFilename);

                                                    try {
                                                      // Upload image to Firebase Storage
                                                      await refUploadImage.putFile(File(file.path));
                                                      String imageUrl = await refUploadImage.getDownloadURL();
                                                      print('Image URL: $imageUrl');

                                                      await FirebaseFirestore.instance
                                                          .collection("users")
                                                          .doc(FirebaseAuth.instance.currentUser!.uid)
                                                          .update({"User_image": imageUrl,});

                                                      print('User data updated successfully');
                                                    } catch (e) {
                                                      print('Error updating user data: $e');
                                                    }

                                                  },

                                                  child: CircleAvatar(
                                                    radius: Dimensions.r20 +
                                                        Dimensions.r20,
                                                    backgroundColor:
                                                    Colors.grey.shade200,
                                                    child: Icon(
                                                      Icons.photo,
                                                      color: Colors.grey,
                                                      size: Dimensions.h35,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: Dimensions.h10,
                                                ),
                                                Text(
                                                  "Gallery",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                      FontWeight.w500,
                                                      fontSize: Dimensions.h18),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          icon: Icon(
                            Icons.add_a_photo,
                            color: Colors.black,
                            size: 22,
                          ),
                        ),
                      )
                    ],
                  ),
                      Text("Name : " + userModel!.name,
                          style: TextStyle(
                              fontSize: Dimensions.h18, color:  Colors.black)),
                  Text("Email : " + userModel!.email,
                      style: TextStyle(
                          fontSize: Dimensions.h15, color: Colors.black)),

                ],
              )),

          ListTile(
            leading: Icon(Icons.shopping_bag, color: Color(0xffF78A00)),
            title: Text("My Orders",
                style:
                TextStyle(fontSize: Dimensions.h20, color: Colors.black)),
            onTap: () {
              Routingpage.gotonext(context: context, navigateto: myorderlist());
            },
          ),
          Divider(
            height: 5,
            color: Colors.grey[400],
          ),
          ListTile(
            onTap: () {
              Routingpage.gotonext(context: context, navigateto: Cart());
            },
            trailing: cartprovider.getcartlist.isNotEmpty
                ? Container(
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Color(0xffF42852),
                shape: BoxShape.circle,
              ),
              child: Text(
                '${cartprovider.getcartlist.length}',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
                : Text(""),
            leading: Icon(Icons.shopping_cart, color: Color(0xffF78A00)),
            title: Text("My Cart",
                style:
                TextStyle(fontSize: Dimensions.h20, color: Colors.black)),
          ),
          Divider(
            height: Dimensions.h5,
            color: Colors.grey[400],
          ),
          ListTile(
            leading: const Icon(Icons.favorite,color: Color(0xffF78A00)),
            title: Text("My Wishlist",
                style:
                TextStyle(fontSize: Dimensions.h20, color: Colors.black)),
            onTap: () {
              Routingpage.gotonext(context: context, navigateto: wishlish());
            },
          ),
          Divider(
            height: Dimensions.h5,
            color: Colors.grey[400],
          ),
          ListTile(
            leading: Icon(Icons.contacts_rounded, color: Color(0xffF78A00)),
            title: Text("Contact Us",
                style:
                TextStyle(fontSize: Dimensions.h20, color: Colors.black)),
            onTap: () {
              Routingpage.gotonext(context: context, navigateto: ContactPage());
            },
          ),
          Divider(
            height: Dimensions.h5,
            color: Colors.grey[400],
          ),
          ListTile(
            leading: Icon(Icons.logout, color: Color(0xffF78A00)),
            title: Text("Logout",
                style:
                TextStyle(fontSize: Dimensions.h20, color: Colors.black)),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("Log Out",
                        style: TextStyle(fontSize: Dimensions.h24)),
                    content: Text(
                      "Are you sure you want to Sign Out?",
                      style: TextStyle(fontSize: Dimensions.h18),
                    ),
                    actions: <Widget>[
                      TextButton(
                        child: Text(
                          "CANCEL",
                          style: TextStyle(fontSize: Dimensions.h20),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: Text(
                          "Log Out",
                          style: TextStyle(
                              fontSize: Dimensions.h24, color: Colors.red),
                        ),
                        onPressed: () {
                          FirebaseAuth.instance.signOut().then((value) {
                            Navigator.pop(context);
                            Routingpage.pushreplase(
                                context: context, navigateto: SplashScreen());
                          });
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
          Divider(
            height: Dimensions.h5,
            color: Colors.grey[400],
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app, color: Color(0xffF78A00)),
            title: Text("Exit",
                style:
                TextStyle(fontSize: Dimensions.h20, color: Colors.black)),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text(
                      "Exit App",
                      style: TextStyle(fontSize: Dimensions.h24),
                    ),
                    content: Text(
                      "Are you sure you want to exit the app?",
                      style: TextStyle(fontSize: Dimensions.h18),
                    ),
                    actions: <Widget>[
                      TextButton(
                        child: Text(
                          "CANCEL",
                          style: TextStyle(fontSize: Dimensions.h20),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: Text(
                          "EXIT",
                          style: TextStyle(
                              color: Colors.red, fontSize: Dimensions.h24),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                          SystemNavigator.pop();
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
          Divider(
            height: 5,
            color: Colors.grey[400],
          ),
        ],
      ),
    );
  }
}
//IconButton(onPressed: ()async{
//                         ImagePicker picker = ImagePicker();
//                         XFile? file = await picker.pickImage(source: ImageSource.gallery);
//                         print('${file?.path}');
//                         if(file==null) return;
//                         String uniquefilename=DateTime.now().millisecondsSinceEpoch.toString();
//                         Reference reference=FirebaseStorage.instance.ref();
//                         Reference refimg= reference.child("images");
//                         Reference refuploadimage=refimg.child(uniquefilename);
//
//                         try {
//                           await refuploadimage.putFile(File(file!.path));
//                           imgurl= await refuploadimage.getDownloadURL();
//                         }catch(e){
//
//                         }
//                       }, icon: Icon(Icons.camera_alt)),

// Positioned(
//   bottom: 2,
//   right: -14,
//   child: IconButton(
//     onPressed: () {
//       showModalBottomSheet(
//         context: context,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.vertical(
//             top: Radius.circular(Dimensions.h20),
//           ),
//         ),
//         builder: (context) {
//           return Container(
//             height: Dimensions.h200,
//             width: double.infinity,
//             child: Padding(
//               padding: EdgeInsets.symmetric(
//                 horizontal: Dimensions.w20,
//               ),
//               child: Column(
//                 mainAxisAlignment:
//                     MainAxisAlignment.spaceEvenly,
//                 crossAxisAlignment:
//                     CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     children: [
//                       Text(
//                         "Profile Photo",
//                         style: TextStyle(
//                           color: Colors.black,
//                           fontWeight: FontWeight.w500,
//                           fontSize: Dimensions.h25,
//                         ),
//                       ),
//                       Spacer(),
//                       InkWell(
//                         onTap: () {
//                           setState(() {
//                             image = null;
//                           });
//                           Navigator.pop(context);
//                         },
//                         child: Icon(
//                           Icons.delete,
//                           color: Colors.grey,
//                           size: Dimensions.w25,
//                         ),
//                       )
//                     ],
//                   ),
//                   Row(
//                     crossAxisAlignment:
//                         CrossAxisAlignment.start,
//                     children: [
//                       Column(
//                         crossAxisAlignment:
//                             CrossAxisAlignment.center,
//                         children: [
//                           InkWell(
//                             onTap: () {
//                               pickImage(ImageSource.camera);
//                               Navigator.pop(context);
//                             },
//                             child: CircleAvatar(
//                               radius: Dimensions.r20 +
//                                   Dimensions.r20,
//                               backgroundColor:
//                                   Colors.grey.shade200,
//                               child: Icon(
//                                 Icons.camera_alt,
//                                 color: Colors.grey,
//                                 size: Dimensions.h35,
//                               ),
//                             ),
//                           ),
//                           SizedBox(
//                             height: Dimensions.h10,
//                           ),
//                           Text(
//                             "Camera",
//                             style: TextStyle(
//                               color: Colors.black,
//                               fontWeight: FontWeight.w500,
//                               fontSize: Dimensions.h10,
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(
//                         width: Dimensions.w50,
//                       ),
//                       Column(
//                         crossAxisAlignment:
//                             CrossAxisAlignment.center,
//                         children: [
//                           InkWell(
//                             onTap: () {
//                               pickImage(
//                                   ImageSource.gallery);
//                               Navigator.pop(context);
//                             },
//                             child: CircleAvatar(
//                               radius: Dimensions.r20 +
//                                   Dimensions.r20,
//                               backgroundColor:
//                                   Colors.grey.shade200,
//                               child: Icon(
//                                 Icons.photo,
//                                 color: Colors.grey,
//                                 size: Dimensions.h35,
//                               ),
//                             ),
//                           ),
//                           SizedBox(
//                             height: Dimensions.h10,
//                           ),
//                           Text(
//                             "Gallery",
//                             style: TextStyle(
//                                 color: Colors.black,
//                                 fontWeight: FontWeight.w500,
//                                 fontSize: Dimensions.h18),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       );
//     },
//     icon: const Icon(
//       Icons.add_a_photo,
//       size: 20,
//     ),
//   ),
// )
