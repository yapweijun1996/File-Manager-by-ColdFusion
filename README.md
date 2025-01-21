# File Manager

A simple web-based File Manager built with HTML, CSS, and ColdFusion (CFML). This application allows users to navigate directories, upload files, download files, and delete files within the server.

## Features

- **Directory Navigation:** Browse through folders on the server.
- **File Upload:** Upload files to the current directory.
- **File Download:** Download existing files.
- **File Deletion:** Delete unwanted files with confirmation.

## Screenshots

![File Manager Screenshot](screenshot.png)

## Requirements

- **Web Server:** Adobe ColdFusion or a compatible CFML engine.
- **Browser:** Modern web browser (Chrome, Firefox, Edge, etc.).

## Installation

1. **Clone the Repository:**
   - git clone https://github.com/yourusername/file-manager.git
   
2. **Deploy to Server:**
   - Copy the `index.cfm` file (or the main file) to your ColdFusion server's web directory.

3. **Set Permissions:**
   - Ensure the server has read/write permissions to the directories you intend to manage.

## Usage

1. **Access the File Manager:**
   - Navigate to `http://yourserver.com/file-manager/index.cfm` in your web browser.

2. **Navigate Folders:**
   - Use the "Current Folder" input to change directories.

3. **Upload Files:**
   - Use the upload form to select and upload files to the current directory.

4. **Download Files:**
   - Click the **Download** link next to a file to download it.

5. **Delete Files:**
   - Click the **Delete** link next to a file and confirm the action to remove it.

## Configuration

- **Script Name Handling:**
  The script dynamically determines its name using `CGI.SCRIPT_NAME`. Ensure your server correctly sets this CGI variable.

- **File Size Limits:**
  Adjust your ColdFusion server settings to handle the desired upload file sizes.

## Security Considerations

- **Access Control:**
  Implement authentication to restrict access to authorized users only.

- **Input Validation:**
  Enhance validation to prevent directory traversal and other security vulnerabilities.

- **File Types:**
  Restrict allowable file types to mitigate security risks.

## Contributing

Contributions are welcome! Please open an issue or submit a pull request for any enhancements or bug fixes.


## Acknowledgements

- Inspired by basic file management needs in web applications.
- Utilizes ColdFusion's powerful file handling capabilities.
