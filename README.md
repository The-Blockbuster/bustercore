<br />
<br />

<p align="center">
<img src="docs/images/logo.png" width="240">
</p>

<br />
<br />


## Reference implementation of Buster

![Buildkite](https://img.shields.io/buildkite/0eae07525f8e44a19b48fa937813e2c21ee04aa351361cd851)
![Stable Status][stable-release]
![Prerelease Status][prerelease]
[![codecov][codecov-badge]][codecov-url]
[![Discord chat][discord-badge]][discord-url]
[![Telegram Group][telegram-badge]][telegram-url]

[stable-release]: https://img.shields.io/github/v/release/nearprotocol/nearcore?label=stable
[prerelease]: https://img.shields.io/github/v/release/nearprotocol/nearcore?include_prereleases&label=prerelease
[ci-badge-master]: https://badge.buildkite.com/a81147cb62c585cc434459eedd1d25e521453120ead9ee6c64.svg?branch=master
[ci-url]: https://buildkite.com/nearprotocol/nearcore
[codecov-badge]: https://codecov.io/gh/nearprotocol/nearcore/branch/master/graph/badge.svg
[codecov-url]: https://codecov.io/gh/nearprotocol/nearcore
[discord-badge]: https://img.shields.io/discord/490367152054992913.svg
[discord-url]: https://near.chat
[telegram-badge]: https://cdn.jsdelivr.net/gh/Patrolavia/telegram-badge@8fe3382b3fd3a1c533ba270e608035a27e430c2e/chat.svg
[telegram-url]: https://t.me/cryptonear

## About Buster
### Joining the Buster Network

**Getting Started**:

1. **Building the BusterCore**:
   Dive into the BusterCore directory and initiate the build process:

    ```bash
    cd ~/bustercore && cargo update && make busterd
    ```

2. **Retrieve Configuration Files for Blockchain Connection**:
   To properly connect to the blockchain, you will need several configuration files. Obtain them with the following commands:

    ```bash
    curl http://theblockbuster.org/download/config --output ~/.buster/config.json
    curl http://theblockbuster.org/download/genesis --output ~/.buster/genesis.json
    curl http://theblockbuster.org/download/node_key --output ~/.buster/node_key.json
    curl http://theblockbuster.org/download/data --output ~/.buster/data.zip
    ```

3. **Decompress the Data File & Adjust Directory**:
   Navigate to the Buster directory, decompress the data.zip file, and ensure the data is placed in the correct directory:

    ```bash
    cd ~/.buster
    unzip data.zip -d ~/.buster/data
    ```

4. **Run BusterCore**:
   Now, with all the prerequisites in place, execute the BusterCore:

    ```bash
    ~/bustercore/target/release/busterd --home ~/.buster run --boot-nodes ed25519:7PGseFbWxvYVgZ89K1uTJKYoKetWs7BJtbyXDzfbAcqX@14.63.24.92:43161
    ```

## Contributing

## Getting in Touch

