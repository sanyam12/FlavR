import 'dart:convert';
import 'package:flavr/core/constants.dart';
import 'package:http/http.dart';


class OutletListApiProvider {
  final Client client;

  OutletListApiProvider(this.client);

  dynamic getAllOutlets() async {
    final response =
        await get(Uri.parse("${API_DOMAIN}outlet/getAllOutlets"));
    return jsonDecode(response.body);
  }

  Future<List<String>> getSavedOutletList(String token, List<String> list) async {
    final List<String> outletLists = [];
    for (var id in list) {
      var response = await client.get(
        Uri.parse(
          "${API_DOMAIN}outlet/getOutlet?outletid=$id"
        ),
        headers: {"Authorization": "Bearer $token"},
      );
      outletLists.add(response.body);
    }
    return outletLists;
  }
}
