import 'package:yemen_travel_guid/constant.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart'as http;



abstract class TripRemoteDataSource{
  Future<dynamic> getTrip();
}


class TripRemoteDataSourceImpl implements TripRemoteDataSource{
  final http.Client client;
  final dio = Dio();

TripRemoteDataSourceImpl({required this.client});

  @override
  Future getTrip() async {


    print(getTripsURL);
    String? token = await getToken();
    print('token = $token');
    print(token);
    final response = await dio.get(getTripsURL,
        options: Options(
            headers: {
              'Accept': 'application/json',
              'Authorization': 'Bearer $token'
            }

        ),
    );

    return Future.value(response);
  }
}