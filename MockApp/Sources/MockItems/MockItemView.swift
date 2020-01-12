//
//  MockItemView.swift
//  MockApp
//
//  Created by Jeroen Rikhof on 10/01/2020.
//  Copyright © 2020 Jeroen Rikhof. All rights reserved.
//

import SwiftUI

struct MockItemView: View {
    
    @Binding var item: MockItem
    
    var body: some View {
        HStack {
            Image(uiImage: getImage())
                .resizable()
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.black, lineWidth: 1.0))
                .frame(width: 70.0, height: 70.0)
            VStack(alignment: .leading) {
                Text("ID:\t\t\t\t \(item.id)" )
                Text("Text: \t\t\t \(item.text)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Text("Confidence:\t\t \(String(format: "%.2f", item.confidence))")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }.padding(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
    }
    
    private func getImage() -> UIImage {
        guard let data = item.imageData,
            let image = UIImage(data: data) else {
            return UIImage(systemName: "photo") ?? UIImage()
        }
        return image
    }
}

#if DEBUG
struct MockItemView_Previews: PreviewProvider {
    
    static let item = MockItem(id: "1",
                               text: "Text",
                               confidence: 0.55,
                               img: "")
    
    static var previews: some View {
        MockItemView(item: .constant(item))
    }
}
#endif
