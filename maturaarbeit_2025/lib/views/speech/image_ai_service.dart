import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:maturaarbeit_2025/env/env.dart';

/// Sends a request to the OpenRouter API using a AAC-simplification prompt.
/// Takes a `text` string and returns the simplified sentence as JSON string array.
Future<List<List<String>>> imageAi(String text) async {
  const timeout = Duration(seconds: 30);

  final apiKey = Env.apiKey;
  final model = Env.openRouterModel;
  final endpoint = Env.openRouterEndpoint;

  if (apiKey.isEmpty || endpoint.isEmpty || model.isEmpty) {
    throw Exception("OpenRouter API credentials missing.");
  }

  // Define system and user prompts
  final prompt = {
    "model": model,
    "messages": [
      {
        "role": "system",
        "content": """
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

Do not use proper names.

If the given sentence already complies with these rules, leave it unchanged.
Output the result only in the format: [["wordx", "wordy", "wordz", ...], ["wordx", "wordy", "wordz", ...]]
Use German as the language for the first array and English as the language for the second array.
Use the same number of words for both translations, so that wordx is also wordx in the other array.
For the English translation of verbs, use the infinitive without "to".
For the German translation use ss instead of sharp S and ALWAYS THE INFINITVE FORM OF VERBS.
""",
      },
      {"role": "user", "content": "Simplify the following sentence: $text"},
    ],
  };

  final headers = {
    "Authorization": "Bearer $apiKey",
    "Content-Type": "application/json",
  };

  try {
    final response = await http
        .post(Uri.parse(endpoint), headers: headers, body: jsonEncode(prompt))
        .timeout(timeout);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final data = jsonDecode(response.body);
      final content = data["choices"][0]["message"]["content"] as String;
      final List<dynamic> result = jsonDecode(content);
      print(result);

      final List<String> aacWords = List<String>.from(result[0]);
      final List<String> translatedPrompt = List<String>.from(result[1]);

      return [aacWords, translatedPrompt];
    } else {
      print("---- OpenRouter Error Response ----");
      print("Status Code: ${response.statusCode}");
      print("Headers: ${response.headers}");
      print("Response Body: ${response.body}");
      print("------------------------------------");
      throw Exception(
        "OpenRouter API returned status ${response.statusCode}: ${response.body}",
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

Future<String> imageCreation(String word) async {
  const timeout = Duration(seconds: 60);
  final replicateKey = Env.replicateKey;
  const endpoint =
      'https://api.replicate.com/v1/models/ideogram-ai/ideogram-v2a-turbo/predictions';

  if (replicateKey.isEmpty) {
    throw Exception("OpenRouter API credentials missing.");
  }

  final headers = {
    "Authorization": "Token $replicateKey",
    "Content-Type": "application/json",
    "Prefer": "wait",
  };

  final prompt = {
    "input": {
      "prompt":
          "Flat vector icon of '$word', black outline, simple colors, white background, no text, no shadows, centered composition, simple and clear design, no decoration, for augmentative and alternative communication (AAC)",
      "aspect_ratio": "1:1",
    },
  };

  try {
    final response = await http
        .post(Uri.parse(endpoint), headers: headers, body: jsonEncode(prompt))
        .timeout(timeout);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final data = jsonDecode(response.body);
      final output = data["output"];
      print(output);
      print(data["status"]);
      if (output != "") {
        return output;
      } else {
        throw Exception("No image URL returned by Replicate.");
      }
    } else {
      print("---- Replicate Error Response ----");
      print("Status Code: ${response.statusCode}");
      print("Headers: ${response.headers}");
      print("Response Body: ${response.body}");
      print("------------------------------------");
      throw Exception(
        "Replicate API returned status ${response.statusCode}: ${response.body}",
      );
    }
  } on http.ClientException catch (e) {
    print("---- Replicate Client Error ----");
    print("Error Message: ${e.message}");
    print("----------------------------------");
    throw Exception("Client error: ${e.message}");
  } on Exception catch (e) {
    print("---- Replicate Request Error ----");
    print("Error: $e");
    print("----------------------------------");
    throw Exception("Error in Replicate request setup: $e");
  }
}
