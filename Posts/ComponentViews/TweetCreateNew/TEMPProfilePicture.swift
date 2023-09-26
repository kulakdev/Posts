//
//  TEMPProfilePicture.swift
//  Posts
//
//  Created by Constantine Kulak on 26.09.2023.
//

import SwiftUI

struct TEMPProfilePicture: View {
    var body: some View {
        Image(systemName: "figure.fall.circle")
            .resizable()
            .frame(width: 48, height: 48)
            .foregroundColor(Color.teal)
            .background(Color.white)
            .clipShape(Circle())
            .padding([.horizontal, .bottom], 7.0)
    }
}

struct TEMPProfilePicture_Previews: PreviewProvider {
    static var previews: some View {
        TEMPProfilePicture()
    }
}
