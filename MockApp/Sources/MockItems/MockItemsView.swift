//
//  MockItemsView.swift
//  MockApp
//
//  Created by Jeroen Rikhof on 10/01/2020.
//  Copyright © 2020 Jeroen Rikhof. All rights reserved.
//

import SwiftUI

struct MockItemsView: View {

    @ObservedObject private var itemList = MockItemList.resolve()
    
    var body: some View {
        GeometryReader { _ in
            NavigationView {
                List(self.itemList.items) { item in
                    VStack(alignment: HorizontalAlignment.leading) {
                        MockItemView(item: .constant(item))
                    }
                }
                .navigationBarTitle("List of items")
            }.onAppear {
                self.itemList.loadItems()
            }
        }
    }
}
    
#if DEBUG
struct MockItemsView_Previews: PreviewProvider {
    static var previews: some View {
        MockItemsView()
    }
}
#endif
