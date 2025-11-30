// Implements local-first, optional cloud fallback:
struct HybridClassifier {
    private let coreModel = ImageClassifier()

    func classify(
        _ image: UIImage,
        allowCloudFallback: Bool
    ) async -> (label: String, confidence: Float) {

        let local = coreModel.classify(image)

        if local.confidence >= 0.8 {
            return local
        }

        guard allowCloudFallback else {
            return ("Unsure", local.confidence)
        }

        // stub for demo – in a real app this calls your server/LLM
        let cloud = await cloudPredict(image)
        return cloud
    }

    private func cloudPredict(_ image: UIImage) async -> (String, Float) {
        // demo only
        return ("cloud_label", 0.9)
    }
}
