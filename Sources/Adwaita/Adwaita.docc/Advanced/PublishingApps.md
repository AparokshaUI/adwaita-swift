# Publishing apps

Learn how to publish your apps using Flatpak.

Once you feel ready to publish your app to [Flathub](https://flathub.org/), or
to a [self-hosted repository](https://docs.flatpak.org/en/latest/hosting-a-repository.html),
you can follow this step-by-step guide.

## Create a Flatpak manifest
You have to create a Flatpak manifest, similar to the one [here](https://github.com/flathub/io.github.david_swift.Flashcards/blob/master/io.github.david_swift.Flashcards.json).
Find detailed information in the [Flatpak documentation](https://docs.flatpak.org/en/latest/manifests.html).
This is the only code that should be submitted to Flathub.
There will be a new repository created under `flathub/app-id` that hosts the manifest.

### SDK Extension for Swift 5
I recommend using the SDK Extension for building the app.
Add the following snippet.

```json
"sdk-extensions": [
  "org.freedesktop.Sdk.Extension.swift5"
]
```

### Generate sources for the Swift Package Manager
You cannot access the web while building the app.
Therefore, you need to add all the dependencies as modules to the manifest file.
This can be automated using the [Flatpak builder tool for SPM](https://github.com/flatpak/flatpak-builder-tools/tree/master/spm).

## MetaInfo file
In the Flatpak Manifest file, under the build commands, you should add the [code to install the app's
MetaInfo file](https://github.com/flathub/io.github.david_swift.Flashcards/blob/c5c0421ffb5589641ddb44a269a6e7e07d430581/io.github.david_swift.Flashcards.json#L49).
The MetaInfo file is located in the app's main repository (not in the Flathub repository).
Take a look at the example [here](https://github.com/david-swift/Memorize/blob/main/data/io.github.david_swift.Flashcards.metainfo.xml).

## Desktop entry file
[This line](https://github.com/flathub/io.github.david_swift.Flashcards/blob/c5c0421ffb5589641ddb44a269a6e7e07d430581/io.github.david_swift.Flashcards.json#L50) in the example installs the Desktop Entry file.
It is located in the [main repository](https://github.com/david-swift/Memorize/blob/main/data/io.github.david_swift.Flashcards.desktop).

## Check the requirements
Before submitting an app to Flathub, make sure to check the [requirements](https://docs.flathub.org/docs/for-app-authors/requirements),
[MetaInfo guidelines](https://docs.flathub.org/docs/for-app-authors/metainfo-guidelines/), and [quality guidelines](https://docs.flathub.org/docs/for-app-authors/metainfo-guidelines/quality-guidelines).
Then, test and submit the app following the [submission instructions](https://docs.flathub.org/docs/for-app-authors/submission).

## Get the badges
Use the [Flathub badges](https://flathub.org/badges) to inform users about the simple installation option.
Even more assets are available [here](https://github.com/flathub-infra/assets).

