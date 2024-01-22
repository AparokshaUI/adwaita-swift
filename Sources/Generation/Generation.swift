//
//  Generation.swift
//  Adwaita
//
//  Created by david-swift on 14.01.24.
//

import Foundation

/// The generation executable.
@main
struct Generation {

    /// The generation configuration.
    var configuration: GenerationConfiguration = .init()

    /// The static main function.
    static func main() throws {
        let generation = Self()
        try generation.run()
    }

    /// The main function.
    func run() throws {
        removeOldFiles()
        let gtkDefinitions = getDefinitions(path: configuration.gtkGirFilePath)
        let adwDefinitions = getDefinitions(path: configuration.adwGirFilePath)
        for `class` in gtkDefinitions?.namespace.classes ?? [] {
            if let config = configuration.gtkWidgets.first(where: { $0.class == `class`.name }) {
                createFile(
                    class: `class`,
                    config: config,
                    classes: gtkDefinitions?.namespace.classes ?? [],
                    configs: configuration.gtkWidgets
                )
            }
        }
        for `class` in adwDefinitions?.namespace.classes ?? [] {
            if let config = configuration.adwWidgets.first(where: { $0.class == `class`.name }) {
                createFile(
                    class: `class`,
                    config: config,
                    classes: adwDefinitions?.namespace.classes ?? [],
                    configs: configuration.adwWidgets
                )
            }
        }
    }

    /// Remove the old files in the generation directory.
    func removeOldFiles() {
        if let fileURLs = try? FileManager.default.contentsOfDirectory(
            at: .init(fileURLWithPath: configuration.folder),
            includingPropertiesForKeys: nil,
            options: .skipsHiddenFiles
        ) {
            for fileURL in fileURLs where fileURL.pathExtension == "swift" {
                print("Removing \(fileURL.lastPathComponent)")
                try? FileManager.default.removeItem(at: fileURL)
            }
        }
    }

    /// Get the definitions of a GIR file at a specified path.
    /// - Parameter path: The path.
    /// - Returns: The GIR data.
    func getDefinitions(path: String) -> GIR? {
        var path = path
        let girDir = getGirDir()
        path.replace(GenerationConfiguration.includeDir, with: girDir)
        let data = (try? Data(contentsOf: .init(fileURLWithPath: path))) ?? .init()
        return try? GIR.decodeGIR(data)
    }

    /// Get the directory of the gir files.
    /// - Returns: The path.
    func getGirDir() -> String {
        let process = Process()
        process.executableURL = .init(fileURLWithPath: "/bin/bash")
        process.arguments = ["-c", "pkg-config --variable=includedir gtk4"]
        let pipe = Pipe()
        process.standardOutput = pipe
        try? process.run()
        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        return .init(data: data, encoding: .utf8)?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
    }

    /// Create a file containing a class.
    /// - Parameters:
    ///     - class: The class.
    ///     - config: The widget configuration.
    ///     - classes: All the available classes.
    ///     - configs: All the available configs.
    func createFile(`class`: Class, config: WidgetConfiguration, classes: [Class], configs: [WidgetConfiguration]) {
        print("Generating \(config.name ?? `class`.name).swift")
        let path = "\(configuration.folder)\(config.name ?? config.class).swift"
        let data = `class`
            .generate(config: config, genConfig: configuration, classes: classes, configs: configs)
            .data(using: .utf8)
        try? data?.write(to: .init(fileURLWithPath: path))
    }

}
