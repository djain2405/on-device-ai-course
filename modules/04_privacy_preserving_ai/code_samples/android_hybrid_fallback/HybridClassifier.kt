class HybridClassifier(
    private val localClassifier: Classifier,
    private val allowCloudFallback: Boolean
) {

    suspend fun classify(bitmap: Bitmap): ClassificationResult {
        val local = localClassifier.classify(bitmap)

        if (local.confidence >= 0.8f) {
            return ClassificationResult(local.label, local.confidence)
        }

        if (!allowCloudFallback) {
            return ClassificationResult("unsure", local.confidence)
        }

        val cloud = cloudPredict(bitmap) // stub
        return cloud
    }

    private suspend fun cloudPredict(bitmap: Bitmap): ClassificationResult {
        // demo only – in reality, upload a derived representation or compressed image
        return ClassificationResult("cloud_label", 0.9f)
    }
}
