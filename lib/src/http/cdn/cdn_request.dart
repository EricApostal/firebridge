import 'package:http/http.dart';

import 'package:nyxx_self/src/client.dart';
import 'package:nyxx_self/src/http/request.dart';

/// A request to Discord's CDN.
class CdnRequest extends HttpRequest {
  /// Create a new [CdnRequest].
  CdnRequest(super.route, {super.queryParameters}) : super(method: 'GET', authenticated: false, applyGlobalRateLimit: false);

  @override
  BaseRequest prepare(Nyxx client) {
    return Request(method, Uri.https(client.apiOptions.cdnHost, route.path));
  }
}
