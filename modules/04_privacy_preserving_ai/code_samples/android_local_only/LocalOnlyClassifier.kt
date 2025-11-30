class LocalOnlyClassifier(private val classifier: Classifier) {

    fun classify(bitmap: Bitmap): ClassificationResult {
        // always on-device
        val res = classifier.classify(bitmap)
        return ClassificationResult(res.label, res.confidence)
    }
}

data class ClassificationResult(val label: String, val confidence: Float)
