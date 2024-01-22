//
//  Icon.swift
//  Adwaita
//
//  Created by david-swift on 21.01.24.
//

import Foundation

// swiftlint:disable type_body_length file_length
/// An icon.
public enum Icon {

    /// A preinstalled icon.
    /// - Parameter icon: The default icon.
    case `default`(icon: DefaultIcon)
    /// A custom icon.
    /// - Parameter name: The icon's name.
    case custom(name: String)

    /// A string representation of the icon.
    public var string: String {
        switch self {
        case let .default(icon):
            return icon.string
        case let .custom(name):
            return name
        }
    }

    /// A preinstalled icon.
    public enum DefaultIcon: String {
        // swiftlint:disable missing_docs identifier_name
        case acAdapter
        case accessoriesCalculator
        case accessoriesCharacterMap
        case accessoriesDictionary
        case accessoriesTextEditor
        case actionUnavailable
        case addressBookNew
        case airplaneMode
        case alarm
        case appRemove
        case appletsScreenshooter
        case applicationCertificate
        case applicationExitRtl
        case applicationExit
        case applicationRss_plus_xml
        case applicationXAddon
        case applicationXAppliance
        case applicationXExecutable
        case applicationXFirmware
        case applicationXSharedlib
        case applicationsEngineering
        case applicationsGames
        case applicationsGraphics
        case applicationsMultimedia
        case applicationsScience
        case applicationsSystem
        case applicationsUtilities
        case appointmentMissed
        case appointmentNew
        case appointmentSoon
        case audioCard
        case audioHeadphones
        case audioHeadset
        case audioInputMicrophone
        case audioSpeakersRtl
        case audioSpeakers
        case audioVolumeHighRtl
        case audioVolumeHigh
        case audioVolumeLowRtl
        case audioVolumeLow
        case audioVolumeMediumRtl
        case audioVolumeMedium
        case audioVolumeMutedRtl
        case audioVolumeMuted
        case audioVolumeOveramplifiedRtl
        case audioVolumeOveramplified
        case audioXGeneric
        case authFace
        case authFingerprint
        case authSimLocked
        case authSimMissing
        case authSim
        case authSmartcard
        case avatarDefault
        case batteryAction
        case batteryCautionCharging
        case batteryCaution
        case batteryEmptyCharging
        case batteryEmpty
        case batteryFullCharged
        case batteryFullCharging
        case batteryFull
        case batteryGoodCharging
        case batteryGood
        case batteryLevel_0Charging
        case batteryLevel_0
        case batteryLevel_10Charging
        case batteryLevel_10
        case batteryLevel_100Charged
        case batteryLevel_100
        case batteryLevel_20Charging
        case batteryLevel_20
        case batteryLevel_30Charging
        case batteryLevel_30
        case batteryLevel_40Charging
        case batteryLevel_40
        case batteryLevel_50Charging
        case batteryLevel_50
        case batteryLevel_60Charging
        case batteryLevel_60
        case batteryLevel_70Charging
        case batteryLevel_70
        case batteryLevel_80Charging
        case batteryLevel_80
        case batteryLevel_90Charging
        case batteryLevel_90
        case batteryLowCharging
        case batteryLow
        case batteryMissing
        case battery
        case bluetoothAcquiring
        case bluetoothActive
        case bluetoothDisabled
        case bluetoothDisconnected
        case bluetoothHardwareDisabled
        case bluetooth
        case bookmarkNew
        case callIncoming
        case callMissed
        case callOutgoing
        case callStart
        case callStop
        case cameraDisabled
        case cameraHardwareDisabled
        case cameraPhoto
        case cameraSwitch
        case cameraVideo
        case cameraWeb
        case capsLock
        case changesAllow
        case changesPrevent
        case channelInsecure
        case channelSecure
        case chatMessageNew
        case checkboxChecked
        case checkboxMixed
        case checkbox
        case colorSelect
        case colorimeterColorhug
        case completionSnippet
        case completionWord
        case computerAppleIpad
        case computerFail
        case computer
        case contactNew
        case contentLoading
        case daytimeSunrise
        case daytimeSunset
        case dialogError
        case dialogInformation
        case dialogPassword
        case dialogQuestion
        case dialogWarning
        case displayBrightness
        case displayProjector
        case documentEdit
        case documentNew
        case documentOpenRecent
        case documentOpen
        case documentPageSetup
        case documentPrintPreview
        case documentPrint
        case documentProperties
        case documentRevertRtl
        case documentRevert
        case documentSaveAs
        case documentSave
        case documentSend
        case driveHarddiskIeee1394
        case driveHarddiskSolidstate
        case driveHarddisk
        case driveHarddiskSystem
        case driveHarddiskUsb
        case driveMultidisk
        case driveOptical
        case driveRemovableMedia
        case editClearAll
        case editClearRtl
        case editClear
        case editCopy
        case editCut
        case editDelete
        case editFindReplace
        case editFind
        case editPaste
        case editRedo
        case editSelectAll
        case editSelect
        case editUndo
        case emblemDefault
        case emblemDocuments
        case emblemFavorite
        case emblemImportant
        case emblemMusic
        case emblemOk
        case emblemPhotos
        case emblemShared
        case emblemSynchronizing
        case emblemSystem
        case emblemVideos
        case emojiActivities
        case emojiBody
        case emojiFlags
        case emojiFood
        case emojiNature
        case emojiObjects
        case emojiPeople
        case emojiRecent
        case emojiSymbols
        case emojiTravel
        case emoteLove
        case errorCorrect
        case faceAngel
        case faceAngry
        case faceConfused
        case faceCool
        case faceCrying
        case faceDevilish
        case faceEmbarrassed
        case faceGlasses
        case faceKiss
        case faceLaugh
        case faceMonkey
        case facePlain
        case faceRaspberry
        case faceSad
        case faceShutmouth
        case faceSick
        case faceSmileBig
        case faceSmile
        case faceSmirk
        case faceSurprise
        case faceTired
        case faceUncertain
        case faceWink
        case faceWorried
        case faceYawn
        case findLocation
        case focusLegacySystray
        case focusTopBar
        case focusWindows
        case folderDocuments
        case folderDownload
        case folderDragAccept
        case folderMusic
        case folderNew
        case folderOpen
        case folderPictures
        case folderPublicshare
        case folderRemote
        case folderSavedSearch
        case folder
        case folderTemplates
        case folderVideos
        case folderVisiting
        case fontSelect
        case fontXGeneric
        case formatIndentLessRtl
        case formatIndentLess
        case formatIndentMoreRtl
        case formatIndentMore
        case formatJustifyCenter
        case formatJustifyFill
        case formatJustifyLeft
        case formatJustifyRight
        case formatTextBold
        case formatTextDirectionLtr
        case formatTextDirectionRtl
        case formatTextDirection
        case formatTextItalic
        case formatTextPlaintext
        case formatTextRich
        case formatTextStrikethrough
        case formatTextUnderline
        case functionLinear
        case gestureSwipeLeft
        case gestureSwipeRight
        case gnomeDisksStateStandby
        case gnomePowerManager
        case goBottom
        case goDown
        case goFirst
        case goHome
        case goJumpRtl
        case goJump
        case goLast
        case goNext
        case goPrevious
        case goTop
        case goUp
        case goaAccountExchange
        case goaAccountGoogle
        case goaAccountLastfm
        case goaAccountMsn
        case goaAccountOwncloud
        case goaAccount
        case goaPanel
        case gtk3Demo
        case gtk3WidgetFactory
        case helpAbout
        case helpBrowser
        case helpContents
        case helpFaq
        case imageLoading
        case imageMissing
        case imageXGeneric
        case info
        case inodeDirectory
        case inputDialpad
        case inputGaming
        case inputKeyboard
        case inputMouse
        case inputTablet
        case inputTouchpad
        case insertImage
        case insertLink
        case insertObject
        case insertText
        case keyboardBrightness
        case langClass
        case langDefine
        case langEnum
        case langEnumValue
        case langFunction
        case langInclude
        case langMethod
        case langNamespace
        case langStructField
        case langStruct
        case langTypedef
        case langUnion
        case langVariable
        case libreofficeBase
        case libreofficeCalc
        case libreofficeDraw
        case libreofficeImpress
        case libreofficeMain
        case libreofficeMath
        case libreofficeWriter
        case listAdd
        case listDragHandle
        case listRemoveAll
        case listRemove
        case locationServicesActive
        case locationServicesDisabled
        case mailAttachment
        case mailForward
        case mailMarkImportant
        case mailMarkJunk
        case mailMarkNotjunk
        case mailMessageNew
        case mailRead
        case mailRepliedRtl
        case mailReplied
        case mailReplyAllRtl
        case mailReplyAll
        case mailReplySender
        case mailSendReceive
        case mailSend
        case mailUnread
        case markLocation
        case mediaEject
        case mediaFlash
        case mediaFloppy
        case mediaOpticalBd
        case mediaOpticalCdAudio
        case mediaOpticalCd
        case mediaOpticalDvd
        case mediaOptical
        case mediaPlaybackPause
        case mediaPlaybackStart
        case mediaPlaybackStop
        case mediaPlaylistConsecutive
        case mediaPlaylistRepeatSong
        case mediaPlaylistRepeat
        case mediaPlaylistShuffle
        case mediaRecord
        case mediaRemovable
        case mediaSeekBackward
        case mediaSeekForward
        case mediaSkipBackward
        case mediaSkipForward
        case mediaTape
        case mediaViewSubtitles
        case mediaZip
        case microphoneDisabled
        case microphoneHardwareDisabled
        case microphoneSensitivityHigh
        case microphoneSensitivityLow
        case microphoneSensitivityMedium
        case microphoneSensitivityMuted
        case modem
        case multimediaPlayerAppleIpodTouch
        case multimediaPlayer
        case multimediaVolumeControl
        case networkCellular_2g
        case networkCellular_3g
        case networkCellular_4g
        case networkCellular_5g
        case networkCellularAcquiringRtl
        case networkCellularAcquiring
        case networkCellularConnected
        case networkCellularDisabledRtl
        case networkCellularDisabled
        case networkCellularEdge
        case networkCellularGprs
        case networkCellularHardwareDisabledRtl
        case networkCellularHardwareDisabled
        case networkCellularHspa
        case networkCellularNoRouteRtl
        case networkCellularNoRoute
        case networkCellularOfflineRtl
        case networkCellularOffline
        case networkCellularSignalExcellentRtl
        case networkCellularSignalExcellent
        case networkCellularSignalGoodRtl
        case networkCellularSignalGood
        case networkCellularSignalNoneRtl
        case networkCellularSignalNone
        case networkCellularSignalOkRtl
        case networkCellularSignalOk
        case networkCellularSignalWeakRtl
        case networkCellularSignalWeak
        case networkCellular
        case networkError
        case networkIdle
        case networkNoRoute
        case networkOffline
        case networkReceive
        case networkServer
        case networkTransmitReceive
        case networkTransmit
        case networkVpnAcquiring
        case networkVpnDisabled
        case networkVpnDisconnected
        case networkVpnNoRoute
        case networkVpn
        case networkWiredAcquiring
        case networkWiredDisconnected
        case networkWiredNoRoute
        case networkWired
        case networkWirelessAcquiring
        case networkWirelessConnected
        case networkWirelessDisabled
        case networkWirelessEncrypted
        case networkWirelessHardwareDisabled
        case networkWirelessHotspot
        case networkWirelessNoRoute
        case networkWirelessOffline
        case networkWirelessSignalExcellent
        case networkWirelessSignalGood
        case networkWirelessSignalNone
        case networkWirelessSignalOk
        case networkWirelessSignalWeak
        case networkWireless
        case networkWorkgroup
        case nightLightDisabled
        case nightLight
        case nmDeviceWiredSecure
        case nmDeviceWired
        case nmDeviceWwan
        case nonStarred
        case notificationsDisabled
        case objectFlipHorizontal
        case objectFlipVertical
        case objectRotateLeft
        case objectRotateRight
        case objectSelect
        case openMenu
        case orca
        case fedoraprojectAnacondaInstaller = "org.fedoraproject.AnacondaInstaller"
        case freedesktopMalcontentControl = "org.freedesktop.MalcontentControl"
        case gnomeAdwaita1Demo = "org.gnome.Adwaita1.Demo"
        case gnomeBoxes = "org.gnome.Boxes"
        case gnomeBuilder = "org.gnome.Builder"
        case gnomeCalculator = "org.gnome.Calculator"
        case gnomeCharacters = "org.gnome.Characters"
        case gnomeCheese = "org.gnome.Cheese"
        case gnomeConsole = "org.gnome.Console"
        case gnomeDiskUtility = "org.gnome.DiskUtility"
        case gnomeEpiphany = "org.gnome.Epiphany"
        case gnomeEvince = "org.gnome.Evince"
        case gnomeLogs = "org.gnome.Logs"
        case gnomeMaps = "org.gnome.Maps"
        case gnomeNautilus = "org.gnome.Nautilus"
        case gnomePhotos = "org.gnome.Photos"
        case gnomeRhythmbox3 = "org.gnome.Rhythmbox3"
        case gnomeSettingsAbout = "org.gnome.Settings-about"
        case gnomeSettingsAccessibility = "org.gnome.Settings-accessibility"
        case gnomeSettingsAppearance = "org.gnome.Settings-appearance"
        case gnomeSettingsApplications = "org.gnome.Settings-applications"
        case gnomeSettingsBluetooth = "org.gnome.Settings-bluetooth"
        case gnomeSettingsCamera = "org.gnome.Settings-camera"
        case gnomeSettingsColor = "org.gnome.Settings-color"
        case gnomeSettingsDefaultApps = "org.gnome.Settings-default-apps"
        case gnomeSettingsDiagnostics = "org.gnome.Settings-diagnostics"
        case gnomeSettingsDisplay = "org.gnome.Settings-display"
        case gnomeSettingsFileHistory = "org.gnome.Settings-file-history"
        case gnomeSettingsKeyboard = "org.gnome.Settings-keyboard"
        case gnomeSettingsLocation = "org.gnome.Settings-location"
        case gnomeSettingsMicrophone = "org.gnome.Settings-microphone"
        case gnomeSettingsMobileNetwork = "org.gnome.Settings-mobile-network"
        case gnomeSettingsMouse = "org.gnome.Settings-mouse"
        case gnomeSettingsMultitasking = "org.gnome.Settings-multitasking"
        case gnomeSettingsNetwork = "org.gnome.Settings-network"
        case gnomeSettingsNotifications = "org.gnome.Settings-notifications"
        case gnomeSettingsOnlineAccounts = "org.gnome.Settings-online-accounts"
        case gnomeSettingsPower = "org.gnome.Settings-power"
        case gnomeSettingsPinters = "org.gnome.Setting-printers"
        case gnomeSettingsRegion = "org.gnome.Settings-region"
        case gnomeSettingsRemovableMedia = "org.gnome.Settings-removable-media"
        case gnomeSettingsSearch = "org.gnome.Settings-search"
        case gnomeSettingsSharing = "org.gnome.Settings-sharing"
        case gnomeSettingsSound = "org.gnome.Settings-sound"
        case gnomeSettings = "org.gnome.Settings"
        case gnomeSettingsSystemLockScreen = "org.gnome.Settings-system-lock-screen"
        case gnomeSettingsThunderbolt = "org.gnome.Settings-thunderbolt"
        case gnomeSettingsTime = "org.gnome.Settings-time"
        case gnomeSettingsUsers = "org.gnome.Settings-users"
        case gnomeSettingsWacom = "org.gnome.Settings-wacom"
        case gnomeShellExtensions = "org.gnome.Shell.Extensions"
        case gnomeSoftware = "org.gnome.Software"
        case gnomeSystemMonitor = "org.gnome.SystemMonitor"
        case gnomeTextEditor = "org.gnome.TextEditor"
        case gnomeTotem = "org.gnome.Totem"
        case gnomeWeather = "org.gnome.Weather"
        case gnomeYelp = "org.gnome.Yelp"
        case gnomeBaobab = "org.gnome.baobab"
        case gnomeClocks = "org.gnome.clocks"
        case gnomeDesignIconLibrary = "org.gnome.design.IconLibrary"
        case gnomeEog = "org.gnome.eog"
        case gnomeFontViewer = "org.gnome.font-viewer"
        case gnomeTweaks = "org.gnome.tweaks"
        case gtkDemo4 = "org.gtk.Demo4"
        case gtkIconBrowser4 = "org.gtk.IconBrowser4"
        case gtkPrintEditor4 = "org.gtk.PrintEditor4"
        case gtkWidgetFactory4 = "org.gtk.WidgetFactory4"
        case gtkGtk4NodeEditor = "org.gtk.gtk4.NodeEditor"
        case orientationLandscapeInverse
        case orientationLandscape
        case orientationPortraitInverse
        case orientationPortraitLeft
        case orientationPortraitRight
        case orientationProtrait
        case packageXGeneric
        case panDown
        case panEnd
        case panStart
        case panUp
        case panelBottom
        case panelCenter
        case panelLeft
        case panelModified
        case panelRight
        case panelTop
        case pda
        case phoneAppleIphone
        case phoneOld
        case phone
        case powerProfileBalancedRtl
        case powerProfileBalanced
        case powerProfilePerformanceRtl
        case powerProfilePerformance
        case powerProfilePowerSaverRtl
        case powerProfilePowerSaver
        case preferencesColor
        case preferencesDesktopAccessibility
        case preferencesDesktopAppearance
        case preferencesDesktopApps
        case preferencesDesktopDisplay
        case preferencesDesktopFont
        case preferencesDesktopKeyboardShortcuts
        case preferencesDesktopKeyboard
        case preferencesDesktopLocale
        case preferencesDesktopMultitasking
        case preferencesDesktopRemoteDesktop
        case preferencesDesktopScreensaver
        case preferencesDesktopWallpaper
        case preferencesOther
        case preferencesSystemDetails
        case preferencesSystemDevices
        case preferencesSystemNetworkProxy
        case preferencesSystemNetwork
        case preferencesSystemNotifications
        case preferencesSystemParentalControls
        case preferencesSystemPrivacy
        case preferencesSystemSearch
        case preferencesSystemSharing
        case preferencesSystem
        case preferencesSystemTime
        case printerError
        case printerNetwork
        case printerPrinting
        case printer
        case printerWarning
        case processStop
        case processWorking
        case radioChecked
        case radioMixed
        case radio
        case rotationAllowed
        case rotationLocked
        case scanner
        case screenShared
        case securityHigh
        case securityLow
        case securityMediumRtl
        case securityMedium
        case selectionEnd
        case selectionMode
        case selectionStart
        case semiStarredRtl
        case semiStarred
        case sendTo
        case sidebarShowRight
        case sidebarShow
        case softwareUpdateAvailable
        case softwareUpdateUrgent
        case speedometer
        case starNew
        case starred
        case startHere
        case switchOff
        case switchOn
        case systemFileManager
        case systemHelp
        case systemLockScreen
        case systemLogOutRtl
        case systemLogOut
        case systemReboot
        case systemRun
        case systemSearch
        case systemShutdown
        case systemSoftwareInstall
        case systemSwitchUserRtl
        case systemSwitchUser
        case systemUsers
        case tabNew
        case tablet
        case taskDue
        case taskPastDue
        case temperature
        case textEditor
        case textXGeneric
        case thunderboltAcquiring
        case thunderbolt
        case toolsCheckSpelling
        case totemTv
        case touchDisabled
        case touchpadDisabled
        case tv
        case uninterruptiblePowerSupply
        case userAvailable
        case userAway
        case userBookmarks
        case userBusy
        case userDesktop
        case userHome
        case userIdle
        case userInfo
        case userInvisible
        case userNotTracked
        case userOffline
        case userStatusPending
        case userTrashFull
        case userTrash
        case utilitiesTerminal
        case valueDecrease
        case valueIncrease
        case videoDisplay
        case videoJoineDisplays
        case videoSingleDisplay
        case videoXGeneric
        case viewAppGrid
        case viewConceal
        case viewContinuous
        case viewDual
        case viewFullscreen
        case viewGrid
        case viewListBulletRtl
        case viewListBullet
        case viewListOrderedRtl
        case viewListOrdered
        case viewListRtl
        case viewList
        case viewMirror
        case viewMoreHorizontal
        case viewMore
        case viewPagedRtl
        case viewPaged
        case viewPin
        case viewRefresh
        case viewRestore
        case viewReveal
        case viewSortAscendingRtl
        case viewSortAscending
        case viewSortDescendingRtl
        case viewSortDescending
        case viewWrappedRtl
        case viewWrapped
        case weatherClearNight
        case weatherClear
        case weatherFewCloudsNight
        case weatherFewClouds
        case weatherFog
        case weatherHourly
        case weatherOvercast
        case weatherSevereAlert
        case weatherShowersScattered
        case weatherShowers
        case weatherSnow
        case weatherStorm
        case weatherTornado
        case weatherWindy
        case webBrowser
        case windowClose
        case windowMaximize
        case windowMinimize
        case windowNew
        case windowRestore
        case xOfficeAddressBook
        case xOfficeCalendar
        case xOfficeDocument
        case xOfficeDrawing
        case xOfficePresentation
        case xOfficeSpreadsheet
        case zoomFitBest
        case zoomIn
        case zoomOriginal
        case zoomOut
        // swiftlint:enable missing_docs identifier_name

        /// A string representation of the icon.
        public var string: String {
            var string = rawValue
            if !string.hasPrefix("org.") {
                let result = string
                    .map { letter in
                        if letter.isUppercase {
                            return "-\(letter)"
                        } else {
                            return "\(letter)"
                        }
                    }
                    .joined()
                string = result.lowercased()
            }
            string = string.replacingOccurrences(of: "_plus_", with: "+")
            string = string.replacingOccurrences(of: "_", with: "-")
            return string + "-symbolic"
        }
    }
}
// swiftlint:enable type_body_length file_length
