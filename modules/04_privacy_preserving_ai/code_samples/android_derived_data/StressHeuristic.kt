enum class StressLevel { LOW, MEDIUM, HIGH }

fun inferStress(features: HeartRateFeatures): StressLevel =
    when {
        features.stdDev > 15 && features.mean > 80 -> StressLevel.HIGH
        features.stdDev > 8 -> StressLevel.MEDIUM
        else -> StressLevel.LOW
    }
