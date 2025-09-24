import CoreImage

extension CIImage {
    func invert() -> CIImage? {
        guard let filter = CIFilter(name: "CIColorInvert") else { return nil }

        filter.setValue(self, forKey: kCIInputImageKey)
        return filter.outputImage
    }
}
