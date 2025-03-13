//
//  ImageModule.swift
//  Concurrency
//
//  Created by Dominic Montalto on 13/03/2025.
//

import SwiftUI

class ImageDownloader {
    private let url = URL(string: "https://picsum.photos/200")!

    func downloadImage() async throws -> UIImage {
        let (data, _) = try await URLSession.shared.data(from: url)
        guard let image = UIImage(data: data) else { throw URLError(.badURL) }
        return image
    }
}

class ImagesViewModel: ObservableObject {
    @Published var image: Image?
    
    private let loader = ImageDownloader()
    
    init() {
        Task { await downloadImage() }
    }
    
    func downloadImage() async {
        do {
            let uiImage = try await loader.downloadImage()
            self.image = Image(uiImage: uiImage)
        } catch {
            
        }
    }
}

struct ImagesModule: View {
    @StateObject var viewModel = ImagesViewModel()
    private let url = URL(string: "https://picsum.photos/200")!
    
    
    var body: some View {
        //        if let image = viewModel.image {
        //            image
        //                .resizable()
        //                .scaledToFill()
        //                .frame(width: 200, height: 200)
        //                .clipShape(.rect(cornerRadius: 10))
        //        } else {
        //            ProgressView()
        //        }
        
        AsyncImage(url: url) { image in
            image
                .resizable()
                .scaledToFill()
                .frame(width: 200, height: 200)
                .clipShape(.rect(cornerRadius: 10))
        } placeholder: {
            ProgressView()
        }
    }
}

#Preview {
    ImagesModule()
}
