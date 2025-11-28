//
//  ContentView.swift
//  OnDeviceClassifierDemo
//
//  Created by Divya Jain on 9/28/25.
//

import SwiftUI
import Vision
import CoreML

struct ContentView: View {
    @State private var image: UIImage?
    @State private var label: String = "Pick an image to classify"
    @State private var showPicker = false

    var body: some View {
        VStack(spacing: 20) {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 300)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }

            Text(label)
                .font(.headline)
                .multilineTextAlignment(.center)
                .padding()

            Button("Choose Photo") { showPicker = true }
                .buttonStyle(.borderedProminent)
        }
        .sheet(isPresented: $showPicker) {
            ImagePicker(selectedImage: $image) { uiImage in
                classify(uiImage)
            }
        }
        .padding()
    }

    private func classify(_ uiImage: UIImage?) {
        guard let ciImage = CIImage(image: uiImage ?? UIImage()) else { return }
        guard let model = try? VNCoreMLModel(for: MobileNetV2(configuration: MLModelConfiguration()).model) else { return }

        let request = VNCoreMLRequest(model: model) { req, _ in
            if let result = req.results?.first as? VNClassificationObservation {
                DispatchQueue.main.async {
                    label = "\(result.identifier) (\(Int(result.confidence * 100))%)"
                }
            }
        }

        try? VNImageRequestHandler(ciImage: ciImage).perform([request])
    }
}


#Preview {
    ContentView()
}
