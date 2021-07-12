# frozen_string_literal: true

require 'discordrb'

bot = Discordrb::Commands::CommandBot.new(
  token: 'YOUR TOKEN', # Your Token
  prefix: 'r', # Your Prefix
  advanced_functionality: true
)

bot.ready do |_|
  bot.dnd
  # bot.profile.name = "I'm a Ruby Bot!" # Rename the bot everytime it starts
end

# The pm method is used to send a private message (also called a DM or direct message) to the user who sent the initial message.
bot.mention do |event|
  event.user.pm('What do you need? :D')
end

# Everytime someone sends "Ping" the bot responds with "Pong!"
bot.message(with_text: 'Ping') do |event|
  event.respond "Pong! #{event.user.name}"
end

bot.command(:ping, description: 'Pong!') do |event|
  event.respond "Pong! #{event.user.name}"
end

# Gives you a random number between 1 and 1000 or a custom range.
bot.command(:random, description: 'Gives you a random number between 1 and 1000', usage: 'random [min] [max]') do |_event, min = 1, max = 1000|
  rand(min.to_i..max.to_i)
end

# This command sends the servers region to the channel.
bot.command(:region, chain_usable: true, description: 'Gets the region the server is stationed in.') do |event|
  event.server.region.name
end

bot.command(:invite, chain_usable: true, description: 'Bot Invite URL') do |event|
  # This simply sends the bot's invite URL, without any specific permissions, to the channel.
  event.bot.invite_url
end

bot.command(:bold, description: 'Makes your message **bold**', usage: 'bold (message)') do |_event, *args|
  # Again, the return value of the block is sent to the channel
  "**#{args.join(' ')}**"
end

bot.command(:italic, description: 'Makes your message *italic*', usage: 'italic (message)') do |_event, *args|
  "*#{args.join(' ')}*"
end

# Bot shutdown command
bot.command(:exit, help_available: false) do |event|
  # This is a check that only allows a user with a specific ID to execute this command. Otherwise, everyone would be able to shut your bot down whenever they wanted.
  break unless event.user.id == 261103679732580352 # Replace number with your ID

  bot.send_message(event.channel.id, 'Bot is shutting down')
  exit
end

# Playing status with custom Text command
bot.command(:game, description: 'Sets game status of the bot.',
                   usage: 'game (text)', min_args: 1) do |event, *text|
  event.bot.game = text.join(' ') if event.author.id == 261103679732580352 # Replace number with your ID
  nil
end

# Watching status with custom Text command
bot.command(:watch, description: 'Sets watch status of the bot.',
                    usage: 'watch (text)', min_args: 1) do |event, *text|
  event.bot.watching = text.join(' ') if event.author.id == 261103679732580352
  nil
end

# Listening status with custom Text command
bot.command(:listen, description: 'Sets listen status of the bot.',
                     usage: 'listen (text)', min_args: 1) do |event, *text|
  event.bot.listening = text.join(' ') if event.author.id == 261103679732580352
  nil
end

# run our bot
bot.run
