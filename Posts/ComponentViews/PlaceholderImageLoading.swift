//
//  PlaceholderImageLoading.swift
//  Posts
//
//  Created by Constantine Kulak on 18.09.2023.
//

import SwiftUI

struct PlaceholderImageLoading: View {
    @State var isRotating = 0.0
    var type: LoadingType = .background

    enum LoadingType {
        case background
        case profilePic
    }

    var body: some View {
        VStack {
            Image(systemName: type == .profilePic ? "person" : "gear")
                .font(.system(size: 48))
                .foregroundColor(.white)
//                .padding()
                .rotationEffect(.degrees(isRotating))
                .onAppear {
                    withAnimation(.linear(duration: 1)
                        .speed(0.1).repeatForever(autoreverses: false)) {
                            isRotating = 360.0
                        }
                }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.blue)
    }
}

struct PlaceholderImageLoading_Previews: PreviewProvider {
    static var previews: some View {
        PlaceholderImageLoading()
            .aspectRatio(CGSize(width: 3, height: 1), contentMode: .fill)
    }
}
