
import 'dart:convert';
import '../env/env.dart';
import '../models/cat_api_model.dart';
import '../models/custom_error.dart';
import 'package:http/http.dart' as http;

// Seth

// CAT API INSTRUCTIONS
// the cat api variable is called 'Env.catApiKey'
// 1. Create a new file called cat_api.dart in the repositories folder - DONE
// 2. Create a new class called CatApirRepository - DONE
// 3. Create a new try/catch block - DONE
class CatApiRepository {
  Future<List<CatBreed>> getCatBreeds() async {
    try {
      // create a variable of type var called client = http.Client();
      var client = http.Client();
      // create a variable of type var called headers = {'x-api-key': Env.catApiKey};
      // create a variable of type var called url = Uri.parse('https://api.thecatapi.com/v1/breeds');
      // create a variable of type var called response = await client.get(url, headers: headers);
      // create if block to check if status code is 200- DONE
      // if (response.statusCode == 200) {
      //   create a List<CatBreed> named catBreeds and assign it to [];
      //   create a variable of type var named jsonString and assign it to jsonDecode(response.body);
      //   for (var item in jsonString) {
      //     catBreeds.add(CatBreed.fromJson(item));
      //   }
      //   return catBreeds;
      // }
    } on Exception catch (e) {
      throw CustomError(
        code: 'Exception',
        message: e.toString(),
        plugin: 'flutter_error/server_error.catApi',
      );
    }
    return [];
  }
}

