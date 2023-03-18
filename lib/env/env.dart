import 'package:envied/envied.dart';

part 'env.g.dart';

// define your environment variables
@Envied(path: '.env')
abstract class Env {
  @EnviedField(varName: 'DOG_API', obfuscate: true)
  static final dogApiKey = _Env.dogApiKey;
  @EnviedField(varName: 'CAT_API', obfuscate: true)
  static final catApiKey = _Env.catApiKey;
}
