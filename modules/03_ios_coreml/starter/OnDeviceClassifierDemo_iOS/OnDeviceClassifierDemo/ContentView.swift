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
                // TODO: call classifier here in final version
                classify(uiImage)
            }
        }
        .padding()
    }

    // Starter stub: returns a placeholder result.
    // In the final version, this will call Core ML (MobileNetV2).
    private func classify(_ uiImage: UIImage?) {
        guard let ciImage = CIImage(image: uiImage ?? UIImage()) else { return }
        
        // TODO: implement using Core ML in the final project.
        return
    }
}


#Preview {
    ContentView()
}
