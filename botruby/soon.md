
## Requirements

For Docker (Recommended):
- A Docker installation, including `docker` and `docker-compose` binaries.
  - On Debian-based Linux distros this is usually as simple as `apt install docker.io docker-compose` - for advanced installations check out [the documentation](https://docs.docker.com/engine/install)

For standalone:
- Ruby 2.4.0+
- Bundler (`gem install bundler`)
- Locally running Redis (`apt install redis-server` ?)


---
## Install and run
1. Clone the repo: `git clone --recursive https://github.com/Royaloakap.git`
2. cd into the repo: `cd BotRuby`

Then either
### Docker (Recommended)
3. Generate a configuration file. You have a few choices:
    - Run the guided script: `docker-compose run royaloakap ./config.rb`
    - Create a `config/config.yml` manually: see `config/README.md` for details.
    - Uncomment and edit the environment variables in `docker-compose.yml`
4. Run the bot: `docker-compose up`  
To fork it to the background, instead use `docker-compose up -d`. You can check the running logs with `docker-compose logs royaloakap`.

or 
### Standalone
3. Create a config file, either through the guided script (`ruby config.rb`) or manually (See `config/README.md`)
4. Install bundler if you haven't already: `gem install bundler`
5. Install the bundle: `bundle install`
6. Run the bot. For Linux: `sh run_linux.sh`. For Windows: `run_windows.bat`.
---
