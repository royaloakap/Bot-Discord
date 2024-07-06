
## Basic Config
1. Enter the config folder. (`cd config`)
2. Create a copy of `config.sample.yml` called `config.yml`. You could rename it, but it will cause issues later if you do. (`cp config.sample.yml config.yml`)
3. Open the file in a text editor. In this example we'll use nano. (`nano config.yml`) Note: DO NOT use Windows Notepad.
4. After `token: `, replace the example one with your own token you noted earlier (Or copy/paste it from the app page directly)
5. After `client_id: `, replace the example number with your own from the app page.
6. Under `prefixes: `, feel free to edit/remove lines to suit your own bot's prefixes. This is the character(s) that will go before commands. For example with a prefix of `s!`, a command would be `s!ping`.
7. If needed, change the `status: ` and `game: ` to your own values. The status is whether the bot is online/idle/dnd/whatever, while the game will be shown as "Playing" by the bot. Set the game to nil to show no Playing text.
8. If desired, change any of the other config options to your own liking. Many have descriptions above them.

```
