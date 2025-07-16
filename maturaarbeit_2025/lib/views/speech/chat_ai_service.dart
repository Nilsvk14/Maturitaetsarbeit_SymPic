import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:maturaarbeit_2025/env/env.dart';

/// Sends a request to the OpenRouter API using a AAC-simplification prompt.
/// Takes a `text` string and returns the simplified sentence as JSON string array.
Future<List<String>> ai(String text) async {
  const timeout = Duration(seconds: 30);

  final apiKey = Env.apiKey;
  final model = Env.openRouterModel;
  final endpoint = Env.openRouterEndpoint;

  if (apiKey.isEmpty || endpoint.isEmpty || model.isEmpty) {
    throw Exception('OpenRouter API credentials missing.');
  }

  // Define system and user prompts
  final prompt = {
    "model": model,
    "messages": [
      {
        "role": "system",
        "content": '''
You are an expert in Augmentative and Alternative Communication (AAC) using pictograms. 
You exclusively use words that appear in the ARASAAC pictogram collection. 
You simplify sentences so that they are understandable for AAC users and can be represented as pictograms.

Rules:

Verbs must be in the infinitive form.

Tenses are represented using time-related words such as “yesterday”, “tomorrow”, etc.

Avoid complex sentence structures.

Homonyms must be clarified with explanations or additional context.

Use only simple conjunctions: “and”, “or”, “but”.

If the sentence is a question, add a question mark.

Use ss instead of sharp S.

Do not use proper names.

If the given sentence already complies with these rules, leave it unchanged.
Output the result in the format: ["word1", "word2", "word3"].
Use German as the language.
''',
      },
      {"role": "user", "content": "Simplify the following sentence: $text"},
    ],
  };

  final headers = {
    'Authorization': 'Bearer $apiKey',
    'Content-Type': 'application/json',
  };

  try {
    final response = await http
        .post(Uri.parse(endpoint), headers: headers, body: jsonEncode(prompt))
        .timeout(timeout);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final data = jsonDecode(response.body);
      final content = data['choices'][0]['message']['content'] as String;
      final List<dynamic> result = jsonDecode(content);

      return result.cast<String>();
    } else {
      print("---- OpenRouter Error Response ----");
      print("Status Code: ${response.statusCode}");
      print("Headers: ${response.headers}");
      print("Response Body: ${response.body}");
      print("------------------------------------");
      throw Exception(
        'OpenRouter API returned status ${response.statusCode}: ${response.body}',
      );
    }
  } on http.ClientException catch (e) {
    print("---- OpenRouter Client Error ----");
    print("Error Message: ${e.message}");
    print("----------------------------------");
    throw Exception("Client error: ${e.message}");
  } on Exception catch (e) {
    print("---- OpenRouter Request Error ----");
    print("Error: $e");
    print("----------------------------------");
    throw Exception("Error in OpenRouter request setup: $e");
  }
}
