import 'package:flutter/material.dart';
import 'package:yemen_travel_guid/constant.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yemen_travel_guid/controllers/governorates_controller.dart';
import 'package:yemen_travel_guid/controllers/user_controller.dart';
import 'package:yemen_travel_guid/models/auth/profile_model.dart';
import 'package:yemen_travel_guid/models/comment_model.dart';
import 'package:yemen_travel_guid/models/governorate_model.dart';


class GovernoratePage extends StatefulWidget {
  final int governorateId;
  const GovernoratePage({super.key, required this.governorateId});

  @override
  State<GovernoratePage> createState() => _GovernoratePageState();
}

class _GovernoratePageState extends State<GovernoratePage> {
  late final GovernorateModel governorate;
  late final CommentModel comment;
  bool loading = false;

  int editIndex = 0;



  @override
  void initState() {
    _getGovernorate();
    super.initState();
  }

  void _getGovernorate() async {
    setState(() {
      loading = true;
    });
    var response = await getGovernorate(widget.governorateId);
    if (response.error == null) {
      governorate = response.data as GovernorateModel;
    } else if (response.error == 'unauthorized') {
      unauthorizedLogout(context);
    } else {
      showErrorSnackBar(
        context: context,
        message: response.error.toString(),
      );
    }
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Scaffold(body: Center(child: CircularProgressIndicator()))
        : Scaffold(
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            SizedBox(
                                height: 230,
                                width: double.infinity,
                                child: Image.network(
                                  governorate.image,
                                  fit: BoxFit.cover,
                                )),
                            Positioned(
                                top: 40,
                                right: 10,
                                child: Row(
                                  children: [
                                    InkWell(
                                      onTap: () => Navigator.pop(context),
                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: SvgPicture.asset(
                                          'assets/images/back.svg',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      governorate.governorateName,
                                      style: const TextStyle(
                                          fontSize: 32,
                                          color: Color(0xffa76f47)),
                                    ),
                                  ],
                                ))
                          ],
                        ),
                        SizedBox(
                            width: double.infinity,
                            child: Image.asset(
                              'assets/images/home/underbanner.png',
                              fit: BoxFit.cover,
                            )),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 8.0, bottom: 8.0, left: 8.0, right: 16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "عن ${governorate.governorateName}",
                                style: const TextStyle(
                                  fontSize: 32,
                                  color: Color(0xffa66e47),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    right: 8.0, bottom: 8.0),
                                child: Text(
                                  governorate.description,
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              if (governorate.location != null)
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "الموقع الجغرافي:",
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Color(0xffa66e47),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 8.0, bottom: 8.0),
                                      child: Text(
                                        governorate.location!,
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              if (governorate.administrativeDivision != null)
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "التقسيم الإداري:",
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Color(0xffa66e47),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 8.0, bottom: 8.0),
                                      child: Text(
                                        governorate.administrativeDivision!,
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              if (governorate.historyAndCulture != null)
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "التاريخ والثقافة:",
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Color(0xffa66e47),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 8.0, bottom: 8.0),
                                      child: Text(
                                        governorate.historyAndCulture!,
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              if (governorate.economy != null)
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "الاقتصاد:",
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Color(0xffa66e47),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 8.0, bottom: 8.0),
                                      child: Text(
                                        governorate.economy!,
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              if (governorate.traditionalDress != null)
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "اللبس التقليدي :",
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Color(0xffa66e47),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        // border: Border.all(color: Colors.grey),
                                      ),
                                      width: 360,
                                      height: 215,
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          child: Image.network(
                                            governorate.traditionalDressImage!,
                                            fit: BoxFit.cover,
                                          )),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 8.0, bottom: 8.0),
                                      child: Text(
                                        governorate.traditionalDress!,
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}
