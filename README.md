# Microsoft Office, OneDrive, and Microsoft Defender Removal Script

## Overview

This script is designed to completely remove Microsoft Office Suite, OneDrive, and Microsoft Defender from a macOS system. It force-quits any running Microsoft applications, removes them from the `/Applications` directory, and deletes all associated files from both system-wide and user-specific directories.

## Features

- Force-quits all Microsoft Office Suite applications, OneDrive, Microsoft AutoUpdate, and Microsoft Defender.
- Removes Microsoft Office Suite applications, OneDrive, and Microsoft Defender from `/Applications`.
- Deletes associated files from `/Library` and user-specific directories.
- Removes Office, OneDrive, and Microsoft Defender icons from the macOS Dock.

## Microsoft Office Suite Applications

The Microsoft Office Suite includes:
- **Microsoft Word**
- **Microsoft Excel**
- **Microsoft PowerPoint**
- **Microsoft Outlook**
- **Microsoft OneNote**
- **Microsoft Teams**
- **Microsoft AutoUpdate**

## Usage

### Prerequisites

- Ensure you have administrative privileges, as the script requires `sudo` to delete system files.
- If `dockutil` is installed, the script will also remove the Office Suite and OneDrive icons from the Dock. Otherwise, it will skip this step.

### Running the Script

1. **Clone the repository:**

    ```sh
    git clone https://github.com/Darknight92228/MacRemove-MS-Office-Onedrive-Defender.git
    ```

2. **Navigate to the script directory:**

    ```sh
    cd MacRemove-MS-Office-Onedrive-Defender
    ```

3. **Make the script executable:**

    ```sh
    chmod +x Remove_MicrosoftSuite.sh
    ```

4. **Run the script:**

    ```sh
    sudo ./Remove_MicrosoftSuite.sh
    ```

## Caution

- **Irreversible Action:** This script will permanently delete Microsoft Office Suite, OneDrive, and Microsoft Defender along with all associated files. Make sure you have backups if needed.
- **Exit on Running Applications:** If any Microsoft applications are still running after attempts to quit, the script will exit to prevent partial uninstallation.

## Contributing

Feel free to fork this repository and submit pull requests. Any improvements or additional features are welcome.

## License

This project is licensed under the GNU General Public License v3.0 (GPL-3.0). See the [LICENSE](LICENSE) file for details.