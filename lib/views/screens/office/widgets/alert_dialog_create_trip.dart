import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:yemen_travel_guid/colors/app_colors.dart';
import 'package:yemen_travel_guid/controllers/office_controller.dart';
import 'package:yemen_travel_guid/controllers/trips_controller.dart';
import 'package:yemen_travel_guid/controllers/user_controller.dart';
import 'package:yemen_travel_guid/cor/util/snackbar_message.dart';
import 'package:dio/dio.dart' as dio;

class AlertDialogCreateTrip extends StatefulWidget {
  const AlertDialogCreateTrip({super.key});

  @override
  State<AlertDialogCreateTrip> createState() => _AlertDialogWidgetState();
}

class _AlertDialogWidgetState extends State<AlertDialogCreateTrip> {

  TextEditingController boardNameController = TextEditingController();
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  bool loading = false;





  dynamic _imageFile;
  final _picker = ImagePicker();
  TextEditingController name = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController subTitle = TextEditingController();
  TextEditingController tripContent = TextEditingController();
  TextEditingController itinerary = TextEditingController();
  TextEditingController price = TextEditingController();

  Future getImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {_imageFile = File(pickedFile.path);});

    }
  }



  Future<bool> _createTrip() async {
    setState(() {
      loading = true;
    });
    var response = await createTrip(await dio.MultipartFile.fromFile(_imageFile.path),name.text,description.text,subTitle.text,tripContent.text,itinerary.text,price.text,);
    if (response.error == null) {
      showSuccessSnackBar(context: context, message: response.message.toString(), );
    return true;
    }
    else if(response.error == 'unauthorized'){
      unauthorizedLogout(context);
      return false;
    }
    else {
      showErrorSnackBar(context: context, message: response.error.toString(), );
    }
    setState(() {
      loading = false;
    });
    return false;

  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formkey,
      child: AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
              20),
        ),
        title: const Text(
          'إضافة رحلة',
          textAlign: TextAlign.center,
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                onTap: ()=> getImage(),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 80,
                    height: 80,
                    clipBehavior: Clip.antiAlias,
                    decoration:  BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      // shape: BoxShape.circle,
                      // color: Colors.grey[300]
                    ),
                    child: _imageFile != null ?  Image.file(
                      _imageFile!,
                      fit: BoxFit.cover,
                    )
                        : Image.asset(
                        'assets/images/noImage.jpg'),

                ),
                      ),
              ),
              TextFormField(
                controller: name,
                decoration: const InputDecoration(labelText: 'الإسم',),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "الرجاء إدخال اسم الرحلة";
                  }
                  return null;
                },
              ),

              TextFormField(
                controller: description,
                maxLines: 2,
                decoration: const InputDecoration(labelText: 'الوصف',),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "الرجاء إدخال وصف الرحلة";
                  }
                  return null;
                },
              ),

              TextFormField(
                controller: subTitle,
                decoration: const InputDecoration(labelText: 'العنوان الفرعي',),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "الرجاء إدخال العنوان الفرعي";
                  }
                  return null;
                },
              ),

              TextFormField(
                controller: tripContent,
                maxLines: 3,
                decoration: const InputDecoration(labelText: 'محتوى الرحلة',),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "الرجاء إدخال محتوى الرحلة";
                  }
                  return null;
                },
              ),

              TextFormField(
                controller: itinerary,
                maxLines: 3,
                decoration: const InputDecoration(labelText: 'مسار الرحلة',),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "الرجاء إدخال مسار الرحلة";
                  }
                  return null;
                },
              ),

              TextFormField(
                controller: price,
                decoration: const InputDecoration(labelText: 'السعر',),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "الرجاء إدخال سعر الرحلة";
                  }
                  return null;
                },
              ),

            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
              child: const Text('إلغاء'),
              onPressed: () => Navigator.of(context).pop(false)),

          loading ? SizedBox(height: 22,width: 22, child: CircularProgressIndicator()) :
          TextButton(
                child: const Text('إنشاء رحلة'),
                onPressed: ()  async {
                  if (formkey.currentState!.validate()){
                    setState(() {
                      loading = true;
                    });
                    if (_imageFile != null)
                     await _createTrip();
                    setState(() {
                      loading = false;
                    });
                    Navigator.of(context).pop(false);
                  }
                },
              )
        ],
      ),
    );
  }
}