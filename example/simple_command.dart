import 'dart:io';

import 'package:nyxx_self/nyxx.dart';

void main() async {
  final client = await Nyxx.connectGateway(
    // Replace this line with a string containing your bot's token, or set
    // the TOKEN environment variable to your token.
    Platform.environment['TOKEN']!,

    // Intents specify which events your bot will receive.
    // The [messageContent] intent is needed to read the content of messages
    // sent on Discord. It is a privileged intent, so you will need to
    // activate it in the developer portal for your application.
    GatewayIntents.allUnprivileged | GatewayIntents.messageContent,

    // We configure our client with the logging and cliIntegration plugins
    // to get logging output and to close the client cleanly when the process
    // is killed.
    options: GatewayClientOptions(plugins: [logging, cliIntegration]),
  );

  // We listen to the onMessageCreate stream which emits an event when the
  // client receives a message.
  client.onMessageCreate.listen((event) async {
    if (event.message.content.startsWith('!pingasdasd')) {
      // Send a message with the content "Pong!", replying to the message that
      // we received.
      // await event.message.channel.sendMessage(MessageBuilder(
      //   content: 'Pong!',
      //   replyId: event.message.id,
      // ));
      print("recieved");
      if (event.guild != null) {
        print(event.guild!.manager.get(event.guild!.id));
      }
    }
  });
}
