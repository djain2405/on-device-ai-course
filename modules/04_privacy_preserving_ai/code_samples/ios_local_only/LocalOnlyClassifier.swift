// Shows a local-only flow with a clear decision to never call cloud:
struct LocalOnlyClassifier {
    private let coreModel = ImageClassifier() // from Module 3

    func classify(_ image: UIImage) -> (label: String, confidence: Float) {
        // always on-device
        return coreModel.classify(image)
    }
}
