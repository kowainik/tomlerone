# tomlerone: Tomland Online

[![MPL-2.0 license](https://img.shields.io/badge/license-MPL--2.0-blue.svg)](LICENSE)

TOML format online checker web application based on the [`tomland`](https://github.com//kowainik/tomland) library.

## Build Instructions

`tomlerone` is a web application that uses `miso` as the framework.

To build the project you need to have `nix` installed on your machine.

Steps:

1. Clone the repo:

   ```
   git clone git@github.com:kowainik/tomlerone.git
   ```

2. Run the following command:

   ```
   nix-build
   ```

3. Open the `index.html` file in your favourite browser:

   ```
   open index.html
   ```
