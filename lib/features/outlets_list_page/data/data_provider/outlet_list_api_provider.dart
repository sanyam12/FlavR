import 'dart:convert';
import 'package:http/http.dart';


class OutletListApiProvider {
  final Client client;

  OutletListApiProvider(this.client);

  dynamic getAllOutlets() async {
    final response =
        await get(Uri.https("flavr.tech", "/outlet/getAllOutlets"));
    return jsonDecode(response.body);
  }

  Future<List<String>> getSavedOutletList(String token, List<String> list) async {
    final List<String> outletLists = [];
    for (var id in list) {
      final query = {"outletid": id};
      var response = await client.get(
        Uri.https(
          "flavr.tech",
          "outlet/getOutlet",
          query,
        ),
        headers: {"Authorization": "Bearer $token"},
      );
      outletLists.add(response.body);
    }
    return outletLists;
  }
}
