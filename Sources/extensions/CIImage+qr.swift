import CoreImage

extension CIImage {
    static func qr(from value: String) -> CIImage? {
        guard let data = value.data(using: .utf8) else { return nil }
        guard let filter = CIFilter(name: "CIQRCodeGenerator") else { return nil }

        filter.setValue(data, forKey: "inputMessage")
        filter.setValue("M", forKey: "inputCorrectionLevel")  // L, M, Q, H

        return filter.outputImage
    }
}
