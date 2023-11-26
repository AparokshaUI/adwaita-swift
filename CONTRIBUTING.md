# Contributing

Thank you very much for taking the time for contributing to this project. 

## Report a Bug
Just open a new issue on GitHub and describe the bug. It helps if your description is detailed. Thank you very much for your contribution!

## Suggest a New Feature
Just open a new issue on GitHub and describe the idea. Thank you very much for your contribution!

### Suggest a New Component
If you want to be able to access a component from Libadwaita or GTK that is currently not available in Adwaita, you can add it to [Libadwaita](https://github.com/AparokshaUI/Libadwaita). 
If you want to add an Adwaita interface for an already existing GTUI widget, open an issue.

## Pull Requests
I am happy for every pull request, you do not have to follow these guidelines. However, it might help you to understand the project structure and make it easier for me to merge your pull request. Thank you very much for your contribution!

### 1. Fork & Clone this Project
Start by clicking on the `Fork` button at the top of the page. Then, clone this repository to your computer. 

### 2. Open the Project
Open the project folder in GNOME Builder, Xcode or another IDE.

### 3. Understand the Project Structure
- The `README.md` file contains a description of the app or package.
- The `Contributors.md` file contains the names or usernames of all the contributors with a link to their GitHub profile.
- The `LICENSE.md` contains an GPL-3.0 license.
- `CONTRIBUTING.md` is this file.
- Directory `Icons` that contains PNG and PXD (Pixelmator Pro) files for the images used in the app and guides.
- Directory `Documentation` that contains the documentation generated with [SourceDocs][1].
- `Sources` contains the source code of the project.
	- `Adwaita` contains the source code of the project.
		- `Model` is the directory with Adwaita's basis.
			- `Data Flow` contains property wrappers and protocols required for managing the updates of a view.
			- `Extensions` contains all the extensions of types that are not defined in this project.
			- `User Interface` contains protocols and structures that are the basis of presenting content to the user.
		- `View` contains structures that conform to the `View` protocol and provide an easier-to-use wrapper around a GTUI `NativeWidgetPeer` type.
	    - `Window` contains structures that conform to the `Window` protocol and simplify the creation of different types of windows.
- `Tests` contains an example application for testing `Adwaita`.

### 4. Edit the Code
Edit the code. If you add a new type, add documentation in the code.

### 5. Commit to the Fork
Commit and push the fork.

### 6. Pull Request
Open GitHub to submit a pull request. Thank you very much for your contribution!

[1]:	https://github.com/SourceDocs/SourceDocs
