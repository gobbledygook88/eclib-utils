eclib-utils
===========

Utility scripts to manage [eclib](https://github.com/JohnCremona/eclib), and its dependencies.

View `install-eclib.sh` for more details on configuration and prerequisites. 

## Brief descriptions

- `install-eclib.sh`: Installs eclib and its dependencies.
- `setup-eclib.sh`: Sets environment variables for a non-`/usr/local/` install.
- `check-nfhpcurve.sh`: Checks for differences in `nfhpcurve` program outputs.

## Roadmap

- Test scripts completely on new system.
- Conduct checks for packages already installed on a system, at provided path and `/usr/local/`.
- Provide an update feature to check for new package versions, and recompile accordingly.
- Use a more modular system so that users may choose which packages to install, depending on use cases.

## Version history

- 2013-05-03: Initial configurations complete. All packages install with correct settings.
