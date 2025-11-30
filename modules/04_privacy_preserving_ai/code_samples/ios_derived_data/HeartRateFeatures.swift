struct HeartRateSample {
    let timestamp: Date
    let bpm: Double
}

struct HeartRateFeatures {
    let mean: Double
    let min: Double
    let max: Double
    let stdDev: Double
}

func computeFeatures(from samples: [HeartRateSample]) -> HeartRateFeatures {
    let values = samples.map { $0.bpm }
    guard !values.isEmpty else {
        return HeartRateFeatures(mean: 0, min: 0, max: 0, stdDev: 0)
    }

    let mean = values.reduce(0, +) / Double(values.count)
    let minV = values.min() ?? mean
    let maxV = values.max() ?? mean
    let variance = values
        .map { pow($0 - mean, 2) }
        .reduce(0, +) / Double(values.count)
    let std = sqrt(variance)

    return HeartRateFeatures(mean: mean, min: minV, max: maxV, stdDev: std)
}
