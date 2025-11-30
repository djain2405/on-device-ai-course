data class HeartRateSample(val timestamp: Long, val bpm: Double)

data class HeartRateFeatures(
    val mean: Double,
    val min: Double,
    val max: Double,
    val stdDev: Double
)

fun computeFeatures(samples: List<HeartRateSample>): HeartRateFeatures {
    if (samples.isEmpty()) return HeartRateFeatures(0.0, 0.0, 0.0, 0.0)

    val values = samples.map { it.bpm }
    val mean = values.average()
    val min = values.minOrNull() ?: mean
    val max = values.maxOrNull() ?: mean
    val variance = values.map { (it - mean) * (it - mean) }.average()
    val stdDev = kotlin.math.sqrt(variance)

    return HeartRateFeatures(mean, min, max, stdDev)
}
