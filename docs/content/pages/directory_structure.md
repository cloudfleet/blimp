- `/opt/cloudfleet/`
  - `engineroom/`
    Scripts and templates for the blimp setup and update
  - `data/`
    - `apps/<appname>/`
      user specific app data (Mailpile index, ...)
      App data 
      - `<username>/`
    - `shared/<category>/`
      Shared data (mails, tls certificates, gpg keys, ...)
      - `<username>/`
        user specific shared data
    - `config/`
      - `apps.yml`
        The apps currently installed on the blimp
      - `cache/`
        Generated config files (`docker-compose.yml`, `nginx.conf`)
    - `logs/`
      CloudFleet logs
