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
        guard let gtkDefinitions = getGtkDefinitions(path: configuration.gtkGirFilePath) else {
            print("failed to get Gtk definitions")
            return
        }

        guard let adwDefinitions = getAdwDefinitions(path: configuration.adwGirFilePath) else {
            print("failed to get Adw definitions")
            return
        }
        for `class` in gtkDefinitions.namespace.classes {
            if let config = configuration.gtkWidgets.first(where: { $0.class == `class`.name }) {
                createFile(
                    class: `class`,
                    config: config,
                    namespace: gtkDefinitions.namespace,
                    configs: configuration.gtkWidgets
                )
            }
        }
        for `class` in adwDefinitions.namespace.classes {
            if let config = configuration.adwWidgets.first(where: { $0.class == `class`.name }) {
                createFile(
                    class: `class`,
                    config: config,
                    namespace: adwDefinitions.namespace,
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
    func getGtkDefinitions(path: String) -> GIR? {
        var path = path
        let girDir = getGtkGirDir()
        path.replace(GenerationConfiguration.gtkIncludeDir, with: girDir)
        let data = (try? Data(contentsOf: .init(fileURLWithPath: path))) ?? .init()
        return try? GIR.decodeGIR(data)
    }

    /// Get the definitions of a GIR file at a specified path.
    /// - Parameter path: The path.
    /// - Returns: The GIR data.
    func getAdwDefinitions(path: String) -> GIR? {
        var path = path
        let girDir = getAdwGirDir()
        path.replace(GenerationConfiguration.adwIncludeDir, with: girDir)
        let data = (try? Data(contentsOf: .init(fileURLWithPath: path))) ?? .init()
        return try? GIR.decodeGIR(data)
    }

    /// Get the directory of the gir files.
    /// - Returns: The path.
    func getGtkGirDir() -> String {
        let process = Process()
        process.executableURL = .init(fileURLWithPath: "/bin/bash")
        process.arguments = ["-c", "pkg-config --variable=includedir gtk4"]
        let pipe = Pipe()
        process.standardOutput = pipe
        try? process.run()
        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        return .init(data: data, encoding: .utf8)?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
    }

    /// Get the directory of the gir files.
    /// - Returns: The path.
    func getAdwGirDir() -> String {
        let process = Process()
        process.executableURL = .init(fileURLWithPath: "/bin/bash")
        process.arguments = ["-c", "pkg-config --variable=includedir libadwaita-1"]
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
    ///     - namespace: The namespace.
    ///     - configs: All the available configs.
    func createFile(`class`: Class, config: WidgetConfiguration, namespace: Namespace, configs: [WidgetConfiguration]) {
        print("Generating \(config.name ?? `class`.name).swift")
        let path = "\(configuration.folder)\(config.name ?? config.class).swift"
        let data = `class`
            .generate(config: config, genConfig: configuration, namespace: namespace, configs: configs)
            .data(using: .utf8)
        try? data?.write(to: .init(fileURLWithPath: path))
    }

}
