import 'dart:convert';
import '../env/env.dart';
import '../models/custom_error.dart';
import 'package:http/http.dart' as http;
import '../models/dog_api_model.dart';

// travis

// DOG API INSTRUCTIONS
// the dog api global variable is called Env.dogApiKey
// 1. Create a new file called dog_api.dart in the repositories folder - DONE
// 2. Create a new class called DogApiRepository - DONE
// 3. Create a new try/catch block - DONE

class DogApiRepository {
  Future<List<DogBreed>> getDogBreeds() async {
    try {
      // create a variable of type var called client = http.Client();
      var client = http.Client();
      // create a variable of type var called headers = {'x-api-key': Env.dogApiKey};
      var headers = {'x-api-key': Env.dogApiKey};
      // create a variable of type var called url = Uri.parse('https://api.thedogapi.com/v1/breeds');
      var url = Uri.parse('https://api.thedogapi.com/v1/breeds');
      // create a variable of type var called response = await client.get(url, headers: headers);
      var response = await client.get(url, headers: headers);
      // create if block to check if status code is 200- DONE
      if (response.statusCode == 200) {
        //   create a List<DogBreed> named dogBreeds and assign it to [];
        List<DogBreed> dogBreeds = [];
        //   create a variable of type var named jsonString and assign it to jsonDecode(response.body);
        var jsonString = jsonDecode(response.body);
        for (var item in jsonString) {
          dogBreeds.add(DogBreed.fromJson(item));
        }
        return dogBreeds;
      }
    } on Exception catch (e) {
      throw CustomError(
          code: 'Exception',
          message: e.toString(),
          plugin: 'flutter_error/server_error ref.getDogBreeds');
    }
    return [];
  }
}
