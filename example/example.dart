import "package:nyxx_self/nyxx.dart";
import 'dart:io';


void main() async {
  final client = await Nyxx.connectGateway(
    Platform.environment['TOKEN']!,
    GatewayIntents.allUnprivileged,
    options: GatewayClientOptions(plugins: [logging, cliIntegration]),
  );

  await for (final MessageCreateEvent(:message) in client.onMessageCreate) {
    print('${message.id} sent by ${message.author.id} in ${message.channelId}!');
  }
}
