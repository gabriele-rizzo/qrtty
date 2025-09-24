import AppKit
import CoreImage

final class QRCode {
    private let image: CIImage
    private let value: String

    init?(from value: String) {
        guard let image: CIImage = .qr(from: value) else { return nil }

        self.value = value
        self.image = image
    }

    func save(to path: String, as format: OutputFormat, size: Int, invert: Bool) throws {
        let context = CIContext()

        let scaleX = CGFloat(size) / image.extent.size.width
        let scaleY = CGFloat(size) / image.extent.size.height
        var scaledImage = image.transformed(by: CGAffineTransform(scaleX: scaleX, y: scaleY))

        if invert {
            guard let invertedImage = scaledImage.invert() else {
                throw NSError(
                    domain: "QRTool", code: 3,
                    userInfo: [NSLocalizedDescriptionKey: "Failed to invert image"])
            }

            scaledImage = invertedImage
        }

        switch format {
        case .png:
            guard let cgImage = context.createCGImage(scaledImage, from: scaledImage.extent) else {
                throw NSError(
                    domain: "QRTool", code: 1,
                    userInfo: [NSLocalizedDescriptionKey: "Failed to render CGImage"])
            }

            let bitmap = NSBitmapImageRep(cgImage: cgImage)

            guard let data = bitmap.representation(using: .png, properties: [:]) else {
                throw NSError(
                    domain: "QRTool", code: 2,
                    userInfo: [NSLocalizedDescriptionKey: "Failed to encode PNG"])
            }

            try data.write(to: URL(fileURLWithPath: path))
        }
    }

    func log(invert: Bool = false) {
        let context = CIContext()
        let cgImage = context.createCGImage(image, from: image.extent)!
        let width = cgImage.width
        let height = cgImage.height

        let colorSpace = CGColorSpaceCreateDeviceGray()
        var pixels = [UInt8](repeating: 0, count: width * height)
        let contextRef = CGContext(
            data: &pixels,
            width: width,
            height: height,
            bitsPerComponent: 8,
            bytesPerRow: width,
            space: colorSpace,
            bitmapInfo: CGImageAlphaInfo.none.rawValue
        )!

        contextRef.draw(cgImage, in: CGRect(x: 0, y: 0, width: width, height: height))

        var output = ""
        for y in 0..<height {
            for x in 0..<width {
                let pixel = pixels[y * width + x]
                let dark = pixel < 128

                if invert {
                    output += dark ? "  " : "██"
                } else {
                    output += dark ? "██" : "  "
                }
            }

            if y < height - 1 {
                output += "\n"
            }
        }

        print("\nContent: \(value)\n")
        print(output)
    }
}
