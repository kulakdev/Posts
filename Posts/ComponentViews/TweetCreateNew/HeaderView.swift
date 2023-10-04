//
//  HeaderView.swift
//  Posts
//
//  Created by Constantine Kulak on 26.09.2023.
//

import SwiftUI
import PhotosUI
import Resolver
struct HeaderView: View {
    @InjectedObject private var appStateManager: AppStateManager
    @InjectedObject private var databaseViewModel: DatabaseViewModel
    @InjectedObject private var storageViewModel: StorageViewModel
    @Binding var selectedPhotos: [PhotosPickerItem]
    var body: some View {
        CrossButton()
        Spacer()
        DEBUGSendToStorage(
            storageViewModel: storageViewModel,
            databaseViewModel: databaseViewModel,
            selectedPhoto: $selectedPhotos)
        Divider()
            .background(.black)
            .frame(height: 2.0)
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        @State var selectedPhotos = [PhotosPickerItem]()
        HeaderView(selectedPhotos: $selectedPhotos)
    }
}
