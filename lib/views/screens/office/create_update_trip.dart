import 'dart:io';
import 'package:flutter/material.dart';
import 'package:yemen_travel_guid/colors/app_colors.dart';
import 'package:yemen_travel_guid/views/screens/office/widgets/text_field_trip.dart';
import 'package:image_picker/image_picker.dart';

class CreateUpdateTrip extends StatefulWidget {
  const CreateUpdateTrip({super.key});

  @override
  State<CreateUpdateTrip> createState() => _CreateUpdateTripState();
}

class _CreateUpdateTripState extends State<CreateUpdateTrip> {
  dynamic _imageFile;
  final _picker = ImagePicker();
  TextEditingController name = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController subTitle = TextEditingController();
  TextEditingController tripContent = TextEditingController();
  TextEditingController itinerary = TextEditingController();
  TextEditingController price = TextEditingController();

  bool isUpdated = false;


  Future getImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {_imageFile = File(pickedFile.path);});

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(50.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
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

              TextFieldTrip(
                  icon: Icon(Icons.password,color: AppColors.primary2,),
                  label: 'تاكيد كلمة المرور',
                  validator: 'password',
                  controller: description,
                maxLines: 1,
              ),
              SizedBox(height: 10,),
              TextFieldTrip(
                icon: Icon(Icons.password,color: AppColors.primary2,),
                label: 'تاكيد كلمة المرور',
                validator: 'password',
                controller: description,
                maxLines: 3,
              ),
              SizedBox(height: 10,),
              TextFieldTrip(
                icon: Icon(Icons.password,color: AppColors.primary2,),
                label: 'تاكيد كلمة المرور',
                validator: 'password',
                controller: description,
                maxLines: 4,
              ),
              SizedBox(height: 10,),
              TextFieldTrip(
                icon: Icon(Icons.password,color: AppColors.primary2,),
                label: 'تاكيد كلمة المرور',
                validator: 'password',
                controller: description,
                maxLines: 4,
              ),
              SizedBox(height: 10,),
              TextFieldTrip(
                icon: Icon(Icons.password,color: AppColors.primary2,),
                label: 'تاكيد كلمة المرور',
                validator: 'password',
                controller: description,
                maxLines: 1,
              ),
              SizedBox(height: 10,),
              TextFieldTrip(
                icon: Icon(Icons.password,color: AppColors.primary2,),
                label: 'تاكيد كلمة المرور',
                validator: 'password',
                controller: description,
                maxLines: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
