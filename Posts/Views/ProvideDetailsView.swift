//
//  ProvideDetailsView.swift
//  Posts
//
//  Created by Constantine Kulak on 25.09.2023.
//

import SwiftUI

struct ProvideDetailsView: View {
    var body: some View {
        Text("Please provide required profile details")
        Text("Name")
        Text("Surname")
        Text("Date of Birth")
        Text("select a profile picture")
    }
}

struct ProvideDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ProvideDetailsView()
    }
}
