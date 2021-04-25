import 'package:covid19tracker/models/all_continents.dart';
import 'package:covid19tracker/models/global_statistics.dart';
import 'package:covid19tracker/services/constants.dart';
import 'package:dio/dio.dart';

class DataService {

  var dio = Dio();

  getAll() async{
    try{
      Response response = await dio.get(AppConstants.allUrl);
      return GlobalStatistics.fromJson(response.data); 
    }
    on DioError catch(e) {
      return e;
    }
   }

   getContinents() async{
     try{
      Response response = await dio.get(AppConstants.continentsUrl);
      response.data.map((e) => AllContinents.fromJson(e));
      return response.data;
    }
    on DioError catch(e) {
      return e;
    }
   }

   getSelectedCountry(countryName) async {
      try{
      Response response = await dio.get(AppConstants.countriesUrl + countryName+ '?yesterday=true&strict=true&query =');
      return response.data;
    }
    on DioError catch(e) {
      return e;
    }
   }

}