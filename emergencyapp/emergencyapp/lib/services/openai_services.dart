import 'dart:convert';
import 'package:http/http.dart' as http;

String apiKey = "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";

Future sendTextCompletionRequest(String message) async {
  String baseUrl = "https://api.openai.com/v1/engines/text-davinci-003/completions";
  Map<String, String> headers = {
    "Content-Type": "application/json",
    "Authorization": "Bearer $apiKey"
  };

  var res = await http.post(
    Uri.parse(baseUrl),
    headers: headers,
    body: json.encode(
      {
        "prompt": message,
        "max_tokens": 100, 
      },
    ),
  );
  if (res.statusCode == 200) {
    return jsonDecode(res.body);
  } else {
    throw Exception("Error en la solicitud a la API de OpenAI");
  }
}
