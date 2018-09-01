import 'package:nyxx/nyxx.dart' as nyxx;
import 'package:nyxx/commands.dart' as command;

import 'dart:io';
import 'dart:async';

// Main function
void main() {
  // Create new bot instance
  // Dart 2 introduces optional new keyword, so we can leave it
  nyxx.Client bot = nyxx.Client(Platform.environment['DISCORD_TOKEN']);

  // Creating new CommandsFramework object and registering commands.
  command.CommandsFramework('!', bot)
    ..admins = [const nyxx.Snowflake.static("302359032612651009")]
    ..registerLibraryCommands();
}

class IsGuildProcessor implements command.Preprocessor {
  const IsGuildProcessor();

  @override
  bool execute(List<Object> services, nyxx.Message message) {
    return message.guild != null;
  }
}

@command.Command(name: "single")
Future<void> single(command.CommandContext context) async {
  await context.reply(content: "WORKING");
}

// Command have to extends CommandContext class and have @Command annotation.
// Method with @Maincommand is main point of command object
// Methods annotated with @Subcommand are defined as subcommands
@command.Module("ping")
class PongCommand extends command.CommandContext {
  @command.Command(main: true)
  @command.Help("Pong!", usage: "ping")
  @IsGuildProcessor()
  Future run() async {
    await reply(content: "Pong!");
  }
}

@command.Module("echo")
class EchoCommand extends command.CommandContext {
  @command.Command(main: true)
  Future run() async {
    await reply(content: message.content);
  }

  @command.Command(name: "perm")
  Future perms() async {
    print((channel as nyxx.GuildChannel).permissions);

    await (channel as nyxx.GuildChannel).editChannelPermission(
        nyxx.PermissionsBuilder()
          ..sendMessages = true
          ..sendTtsMessages = false,
        client.users[nyxx.Snowflake("471349482307715102")]);

    for (var perm in (channel as nyxx.GuildChannel).permissions) {
      var role = guild.roles.values.firstWhere((i) => i.id == perm.id);
      print(
          "Entity: ${perm.id} with ${perm.type} as ${role.name} can?: ${perm.permissions.viewChannel}");
    }
  }
}

// Aliases have to be `const`
@command.Module("alias", aliases: ["aaa"])
class AliasCommand extends command.CommandContext {
  @command.Command(main: true)
  Future run() async {
    await reply(content: message.content);
  }
}
