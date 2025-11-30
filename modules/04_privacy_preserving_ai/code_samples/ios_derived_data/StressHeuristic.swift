// A simple heuristic “model” using features:
enum StressLevel: String {
    case low, medium, high
}

func inferStress(from features: HeartRateFeatures) -> StressLevel {
    if features.stdDev > 15 && features.mean > 80 {
        return .high
    } else if features.stdDev > 8 {
        return .medium
    } else {
        return .low
    }
}
