// lib/env/env.dart
import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
final class Env {
  @EnviedField(varName: 'API_KEY', obfuscate: true)
  static final String apiKey = _Env.apiKey;
  @EnviedField(varName: 'OPENROUTER_MODEL')
  static final String openRouterModel = _Env.openRouterModel;
  @EnviedField(varName: 'OPENROUTER_ENDPOINT', obfuscate: true)
  static final String openRouterEndpoint = _Env.openRouterEndpoint;
  @EnviedField(varName: 'REPLICATE_API_KEY', obfuscate: true)
  static final String replicateKey = _Env.replicateKey;
}
