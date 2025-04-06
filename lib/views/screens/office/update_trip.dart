import 'dart:io';
import 'package:flutter/material.dart';
import 'package:yemen_travel_guid/colors/app_colors.dart';
import 'package:yemen_travel_guid/controllers/city_controller.dart';
import 'package:yemen_travel_guid/controllers/trips_controller.dart';
import 'package:yemen_travel_guid/controllers/user_controller.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yemen_travel_guid/models/city_model.dart';
import 'package:yemen_travel_guid/models/trip_model.dart';
import 'package:yemen_travel_guid/views/screens/office/widgets/text_field_trip.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart' as dio;
import 'package:yemen_travel_guid/constant.dart';
class UpdateTrip extends StatefulWidget {
  final TripModel trip;
  const UpdateTrip({super.key,required this.trip});

  @override
  State<UpdateTrip> createState() => _UpdateTripState();
}

class _UpdateTripState extends State<UpdateTrip> {
  int? selectedValue = 1;
  List<CityModel> cities = [];
  bool loadingCities = true;

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

  dynamic _imageFile;
  Future getImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<bool> _updateTrip() async {
    setState(() {
      loading = true;
    });
    dio.MultipartFile? imageFilePart;
    if (_imageFile != null) {
      imageFilePart = await dio.MultipartFile.fromFile(_imageFile.path);
    }
    var response = await updateTrip(
        imageFilePart,
        name.text,
        description.text,
        subTitle.text,
        tripContent.text,
        itinerary.text,
        price.text,
        selectedValue.toString(),
        '${widget.trip.id}',);
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

  @override
  void initState() {
    super.initState(); // يجب أن يكون هذا في أعلى الدالة
    name.text = widget.trip.name;
    description.text = widget.trip.description;
    subTitle.text = widget.trip.subTitle;
    tripContent.text = widget.trip.tripContent;
    itinerary.text = widget.trip.itinerary;
    price.text = widget.trip.price.toString();
    selectedValue = widget.trip.city!.id;
    // _imageFile = File(widget.trip.image);

    // تحميل المدن وتعيين المدينة المحددة
    _getCities();
  }

  void _getCities() async {
    var response = await getCities();
    if (response.error == null) {
      cities = response.data as List<CityModel>;

      // تعيين المدينة المحددة هنا بعد تحميل المدن
      setState(() {
        // selectedValue = widget.trip.city!.id; // تعيين المدينة الخاصة بالرحلة
      });
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            color: AppColors.primary0,
            child:  Padding(
              padding: EdgeInsets.only(top: 50.0, right: 12, bottom: 10),
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
                  Text(
                    'تعديل الرحلة',
                    style: TextStyle(
                      fontSize: 22,
                      color: AppColors.titleColor,
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
                    width: 300,
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
                              : Image.network(
                            widget.trip.image,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFieldTrip(
                    icon: const Icon(
                      Icons.abc,
                      color: AppColors.primary2,
                    ),
                    label: 'الاسم',
                    validator: 'required',
                    controller: name,
                    maxLines: 1,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFieldTrip(
                    icon: const Icon(
                      Icons.abc,
                      color: AppColors.primary2,
                    ),
                    label: 'العنوان الفرعي',
                    validator: 'required',
                    controller: subTitle,
                    maxLines: 3,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFieldTrip(
                    icon: const Icon(
                      Icons.abc,
                      color: AppColors.primary2,
                    ),
                    label: 'الوصف',
                    validator: 'required',
                    controller: description,
                    maxLines: 4,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFieldTrip(
                    icon: const Icon(
                      Icons.abc,
                      color: AppColors.primary2,
                    ),
                    label: 'المحتوى',
                    validator: 'required',
                    controller: tripContent,
                    maxLines: 4,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFieldTrip(
                    icon: const Icon(
                      Icons.abc,
                      color: AppColors.primary2,
                    ),
                    label: 'خطة السير',
                    validator: 'required',
                    controller: itinerary,
                    maxLines: 1,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFieldTrip(
                    icon: const Icon(
                      Icons.price_change,
                      color: AppColors.primary2,
                    ),
                    label: 'السعر',
                    validator: 'required',
                    controller: price,
                    maxLines: 1,
                  ),

                  const SizedBox(height: 10),






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
                          color: AppColors.primary1,
                        ),
                        value: selectedValue,
                        onChanged: (var newValue) {
                          setState(() {
                            selectedValue = newValue;
                          });
                        },
                        icon: const Icon(Icons.arrow_drop_down, color: AppColors.primary1),
                        items: cities.map((value) {
                          return DropdownMenuItem(
                            value: value.id,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(left: 13,right: 2),
                                  child: Icon(Icons.location_on, size: 20,color: AppColors.primary2),
                                ),
                                Expanded(
                                  child: Text(
                                    value.cityName,
                                    textAlign: TextAlign.start,
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
                            _updateTrip();
                          }

                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary2,
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
