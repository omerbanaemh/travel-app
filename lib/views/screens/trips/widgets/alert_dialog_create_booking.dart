import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:yemen_travel_guid/controllers/trips_controller.dart';
import 'package:yemen_travel_guid/controllers/user_controller.dart';

import 'package:dio/dio.dart' as dio;
import 'package:yemen_travel_guid/constant.dart';
class AlertDialogCreateBooking extends StatefulWidget {
  final tripId;
  const AlertDialogCreateBooking({super.key,required this.tripId});

  @override
  State<AlertDialogCreateBooking> createState() => _AlertDialogWidgetState();
}

class _AlertDialogWidgetState extends State<AlertDialogCreateBooking> {
  TextEditingController boardNameController = TextEditingController();
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  bool createBookingLoading = false;





  dynamic _imageFile;
  final _picker = ImagePicker();
  TextEditingController txtNameController = TextEditingController();
  TextEditingController txtEmailController = TextEditingController();

  Future getImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {_imageFile = File(pickedFile.path);});

    }
  }



  Future<bool> _createBooking() async {
    setState(() {
      createBookingLoading = true;
    });
    var response = await createBooking( await dio.MultipartFile.fromFile(_imageFile.path),widget.tripId );
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
      createBookingLoading = false;
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
          'أرفاق صورة الدفع ',
          textAlign: TextAlign.center,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: ()=> getImage(),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 110,
                  height: 110,
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

          ],
        ),
        actions: <Widget>[
          TextButton(
              child: const Text('إلغاء'),
              onPressed: () => Navigator.of(context).pop(false)),

          createBookingLoading ? const SizedBox(height: 22,width: 22, child: CircularProgressIndicator()) :
          TextButton(
                child: const Text('حجز'),
                onPressed: ()  async {
                  if (formkey.currentState!.validate()){
                    setState(() {
                      createBookingLoading = true;
                    });
                    if (_imageFile != null) {
                      await _createBooking().then((value) => {
                       if(value == true){
                         Navigator.of(context).pop(true),
                       }else(
                       Navigator.of(context).pop(false)
                       )
                     });
                    }
                    setState(() {
                      createBookingLoading = false;
                    });
                  }
                },
              )
        ],
      ),
    );
  }

}