import 'dart:io';
import 'package:flutter/material.dart';
import 'package:yemen_travel_guid/controllers/city_controller.dart';
import 'package:yemen_travel_guid/controllers/trips_controller.dart';
import 'package:yemen_travel_guid/controllers/user_controller.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yemen_travel_guid/models/city_model.dart';
import 'package:yemen_travel_guid/views/screens/office/widgets/text_field_trip.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart' as dio;
import 'package:yemen_travel_guid/constant.dart';
class CreateTrip extends StatefulWidget {
  const CreateTrip({super.key});

  @override
  State<CreateTrip> createState() => _CreateTripState();
}

class _CreateTripState extends State<CreateTrip> {
  int? selectedValue;
  List<CityModel> cities = [];
  bool loadingCities = true;
  dynamic _imageFile;
  final _picker = ImagePicker();
  bool loading = false;
  TextEditingController name = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController subTitle = TextEditingController();
  TextEditingController tripContent = TextEditingController();
  TextEditingController itinerary = TextEditingController();
  TextEditingController price = TextEditingController();

  bool isUpdated = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future getImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<bool> _createTrip() async {
    setState(() {
      loading = true;
    });
    var response = await createTrip(
        await dio.MultipartFile.fromFile(_imageFile.path),
        name.text,
        description.text,
        subTitle.text,
        tripContent.text,
        itinerary.text,
        price.text,
        '11');
    if (response.error == null) {
       showSuccessSnackBar(
        context: context,
        message: response.message.toString(),
      );
      Navigator.pop(context);
      return true;
    } else if (response.error == 'unauthorized') {
      unauthorizedLogout(context);
      return false;
    } else {
      showErrorSnackBar(
        context: context,
        message: response.error.toString(),
      );
    }
    setState(() {
      loading = false;
    });
    return false;
  }

  void _getCities() async {
    var response = await getCities();
    if (response.error == null) {
      cities = response.data as List<CityModel>;
      selectedValue = cities[0].id;
    } else if (response.error == 'unauthorized') {
      unauthorizedLogout(context);
    } else {
      showErrorSnackBar(
        context: context,
        message: response.error.toString(),
      );
    }
    setState(() {
      loadingCities = false;
    });
  }

  @override
  void initState() {
    _getCities();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            color: const Color(0xFFECE0D9),
            child:  Padding(
              padding: const EdgeInsets.only(top: 50.0, right: 12, bottom: 10),
              child: Row(
                children: [
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: SvgPicture.asset(
                        'assets/images/back.svg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const Text(
                    'إضافة رحلة',
                    style: TextStyle(
                      fontSize: 22,
                      color: Color(0xFFA76F47),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Form(
              key: formKey,
              child: ListView(
                padding: const EdgeInsets.all(33),
                children: [
                  Container(
                    width: 307,
                    height: 200,
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFDFDFE),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 5,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: InkWell(
                      onTap: () => getImage(),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 80,
                          height: 80,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: _imageFile != null
                              ? Image.file(
                                  _imageFile!,
                                  fit: BoxFit.cover,
                                )
                              : const Icon(
                            Icons.camera_alt_rounded,
                            size: 120,
                            color: Color(0xFFC08759),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFieldTrip(
                    icon: const Icon(
                      Icons.card_travel,
                      color: Color(0xFFC08759),
                    ),
                    label: 'الاسم',
                    validator: 'required',
                    controller: name,
                    maxLines: 1,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFieldTrip(
                    icon: const Icon(
                      Icons.border_color,
                      size: 15,
                      color: Color(0xFFC08759),
                    ),
                    label: 'العنوان الفرعي',
                    validator: 'required',
                    controller: subTitle,
                    maxLines: 2,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFieldTrip(
                    icon: const Icon(
                      Icons.edit_note,
                      size: 25,
                      color: Color(0xFFC08759),
                    ),
                    label: 'الوصف',
                    validator: 'required',
                    controller: description,
                    maxLines: 4,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFieldTrip(
                    icon: const Icon(
                      Icons.edit_note_sharp,
                      size: 25,
                      color: Color(0xFFC08759),
                    ),
                    label: 'المحتوى',
                    validator: 'required',
                    controller: tripContent,
                    maxLines: 4,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFieldTrip(
                    icon: const Icon(
                      Icons.credit_card,
                      color: Color(0xFFC08759),
                    ),
                    label: 'خطة السير',
                    validator: 'required',
                    controller: itinerary,
                    maxLines: 3,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFieldTrip(
                    icon: const Icon(
                      Icons.price_change,
                      color: Color(0xFFC08759),
                    ),
                    label: 'السعر',
                    validator: 'required',
                    controller: price,
                    maxLines: 1,
                  ),

                  const SizedBox(height: 20),

                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    width: 300,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFDFDFE),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 5,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        isExpanded: true,
                        style: const TextStyle(
                          color: Color(0xFFCE9263),
                        ),
                        value: selectedValue,
                        onChanged: (var newValue) {
                          setState(() {
                            selectedValue = newValue;
                          });
                        },
                        icon: const Icon(Icons.arrow_drop_down, color: Color(0xFFCE9263)),
                        items: cities.map((value) {
                          return DropdownMenuItem(
                            value: value.id,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(left: 13,right: 2),
                                  child: Icon(Icons.location_on, size: 20,color: Color(0xFFC08759)),
                                ),
                                Expanded(
                                  child: Text(
                                    value.cityName,
                                    textAlign: TextAlign.start, // للتأكد من محاذاة النص إلى اليسار
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    )
                  ),

                  const SizedBox(height: 20,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey,
                          foregroundColor: Colors.white,
                          padding:
                              const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        ),
                        child: const Text('إلغاء'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()){
                            _createTrip();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFC08759),
                          foregroundColor: Colors.white,
                          padding:
                              const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        ),
                        child: const Text('حفظ'),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
