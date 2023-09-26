//
//  CrossButton.swift
//  Posts
//
//  Created by Constantine Kulak on 26.09.2023.
//

import SwiftUI

struct CrossButton: View {
    var body: some View {
        Button {

        } label: {
            Image(systemName: "xmark")
                .resizable()
                .frame(width: 16, height: 16)
                .padding()
                .padding(.leading, 5.0)
        }
    }
}

struct CrossButton_Previews: PreviewProvider {
    static var previews: some View {
        CrossButton()
    }
}
