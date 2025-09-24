import ArgumentParser

@main
struct qrtty: ParsableCommand {
    @Argument(help: "QR code content")
    var content: String

    @Option(name: .shortAndLong, help: "QR code output file path")
    var output: String?

    @Option(name: .shortAndLong, help: "QR code output format")
    var format: OutputFormat = .png

    @Option(name: .shortAndLong, help: "QR code output size")
    var size: Int = 256

    @Flag(name: .shortAndLong, help: "Enable inverted colors")
    var invert: Bool = false

    mutating func run() throws {
        guard let code = QRCode(from: content) else { throw ValidationError("Invalid content") }
        guard let output else {
            code.log(invert: invert)

            return
        }

        try code.save(to: output, as: format, size: size, invert: invert)
    }
}
