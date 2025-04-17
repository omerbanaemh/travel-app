import 'package:flutter/material.dart';
import 'package:yemen_travel_guid/constant.dart';
import 'package:yemen_travel_guid/controllers/governorates_controller.dart';
import 'package:yemen_travel_guid/controllers/user_controller.dart';
import 'package:yemen_travel_guid/models/governorate_model.dart';
import 'package:yemen_travel_guid/views/screens/governorates/governorate_page.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GovernoratesPage extends StatefulWidget {
  const GovernoratesPage({super.key});

  @override
  State<GovernoratesPage> createState() => _GovernoratesPageState();
}

class _GovernoratesPageState extends State<GovernoratesPage> {
  bool loading = true;
  List<GovernorateModel> governorates = [];
  @override
  void initState() {
    _getGovernorates();
    super.initState();
  }



  Future<void> _getGovernorates() async {
    var response = await getGovernorates();
    if (response.error == null) {
      governorates = response.data as List<GovernorateModel>;
    }else if(response.error == 'unauthorized'){
      unauthorizedLogout(context);
    } else {
      showErrorSnackBar(context: context, message: response.error.toString(), );
    }
    setState(() {
      loading = false;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
            children: [
              Container(
                width: double.infinity,
                color: const Color(0xFFECE0D9),
                child:   Padding(
                  padding:
                      const EdgeInsets.only(top: 50.0, right: 12, bottom: 10,left: 22),
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
                        'المحافظات',
                        style: TextStyle(
                          fontSize: 22,
                          color: Color(0xFFA76F47),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              loading ? const Expanded(child: Center(child: CircularProgressIndicator())) :

          Expanded(
                child: RefreshIndicator(
                  onRefresh: ()  {return _getGovernorates();},
                  child: ListView.builder(
                    padding: const EdgeInsets.only(top: 10,bottom: 50),
                    itemCount: governorates.length ,
                    itemBuilder: (context, index) {
                      GovernorateModel governorate = governorates[index];

                        return Column(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (_) =>  GovernoratePage(governorateId:governorate.id)));
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 22),
                                child: Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(18),
                                        image: DecorationImage(
                                          image:
                                          NetworkImage(governorate.image),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      width: 90,
                                      height: 76,
                                      // child: Image.asset(item[index]['image']!),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            governorate.governorateName,
                                            style: const TextStyle(
                                                fontSize: 20,
                                                color: Color(0xFFA76F47)),
                                          ),
                                          Text(
                                            governorate.description,
                                            style: const TextStyle(
                                                fontSize: 16,
                                                color: Colors.black54),
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const Divider()
                          ],
                        );

                    },
                  ),
                ),
              )

            ],
          ),
    ) ;


  }

  // void _listener(BuildContext context, TripState state) {
  //
  // }
}
