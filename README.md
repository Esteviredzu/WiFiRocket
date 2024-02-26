# WifiRocket wi-fi connector

This bash script allows users to connect to Wi-Fi networks using the command line interface. It provides options to connect to both WPA2 protected networks and open networks.

## Features

- Connects to available Wi-Fi networks.
- Supports WPA2 protected networks.
- Automatically enables Wi-Fi if it's disabled.

## Requirements

- Linux operating system
- NetworkManager command-line utility (`nmcli`)

## Usage

1. Make sure your Wi-Fi is enabled.
2. Run the script in your terminal:

    ```bash
    ./wifi_connector.sh
    ```

3. Follow the on-screen instructions to select and connect to a Wi-Fi network.

For WPA2 protected networks, you'll be prompted to enter the password.

## License

This project is licensed under the GNU General Public License v3.0 - see the [LICENSE](LICENSE) file for details.
