- To run fastboot test:
in simplepractice:
```bash
sp -e FASTBOOT=true -e CONFIG__CLIENT_PORTAL__HOST=client-portal.local rspec spec/features/client_portal_app/home_spec.rb
```

in client-portal:
```bash
sp -e PUBLIC_ASSET_URL=http://client-portal.local:4200/ -e RAILS_ENV=test yarn start -- --port 4200 --proxy http://client-portal-app.simplepractice.local:4201
```
- you have to run linter commands inside the container, which you can access with the cli "sp"
- Never add Claude code attribution to commit messages
- Prefix bash commands with "sp --" if you want to run them in the container. For example, to run "chromium-browser --version", you should run "sp -- chromium-browser --version"
