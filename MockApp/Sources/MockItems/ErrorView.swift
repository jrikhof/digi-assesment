//
//  ErrorView.swift
//  MockApp
//
//  Created by Jeroen Rikhof on 13/01/2020.
//  Copyright © 2020 Jeroen Rikhof. All rights reserved.
//

import SwiftUI

struct ErrorView: View {
    
    private let error: Error
    
    init(for error: Error) {
        self.error = error
    }
    
    private var errorMessage: String {
        let err = (error as NSError)
        if err.code == -999 {
            return "Connection is not secure!"
        }
        
        return error.localizedDescription
    }
    
    var body: some View {
        VStack {
            Image(systemName: "cloud.bolt.rain")
                .resizable()
                .frame(width: 150.0, height: 150.0)
                .foregroundColor(Color(UIColor.digiGray))

            Text(errorMessage)
                .foregroundColor(Color(UIColor.digiGray))
        }
    }
}

#if DEBUG
struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(for: NoDataError())
    }
}

#endif
