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
Output the result only in the format: [["word1", "word2", "word3"], ["word1", "word2", "word3"]]
Use German as the language for the first array and English as the language for the second array.
Use the same amount of words for both translation, so that wordx is also wordx in the other array.
For the English translation of verbs, use the infinitive without "to".
For the German translation use ss instead of sharp S.
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
  const timeout = Duration(seconds: 30);
  final replicateKey = Env.replicateKey;
  const endpoint = 'https://api.replicate.com/v1/predictions';

  if (replicateKey.isEmpty) {
    throw Exception("OpenRouter API credentials missing.");
  }

  final headers = {
    "Authorization": "Token $replicateKey",
    "Content-Type": "application/json",
    "Prefer": "wait=30",
  };

  final prompt = {
    "version":
        "stability-ai/sdxl:7762fd07cf82c948538e41f63f77d685e02b063e37e496e96eefd46c929f9bdc",
    "input": {
      "width": 512,
      "height": 512,
      "prompt":
          "Flat pictogram of '$word', ARASAAC style, white background, minimal line-art, simple colors",
      "refine": "no_refiner",
      "scheduler": "K_EULER",
      "num_outputs": 1,
      "guidance_scale": 12,
      "apply_watermark": false,
      "high_noise_frac": 0.6,
      "negative_prompt": "shading, background, photo, 3D",
      "num_inference_steps": 30,
    },
  };

  try {
    final response = await http
        .post(Uri.parse(endpoint), headers: headers, body: jsonEncode(prompt))
        .timeout(timeout);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final data = jsonDecode(response.body);
      final output = data["output"];
      print(data["status"]);
      if (output is List && output.isNotEmpty) {
        final imageUrl = output.first.toString();
        return imageUrl;
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
