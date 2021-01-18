//
//  TagModifier.swift
//  awesomeBeers
//
//  Created by Luana Chen Chih Jun on 18/01/21.
//  Copyright © 2021 Luana Chen. All rights reserved.
//

import SwiftUI

struct TagStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title3)
            .padding(EdgeInsets(top: 8, leading: 20, bottom: 8, trailing: 20))
            .foregroundColor(.white)
            .background(Color(#colorLiteral(red: 0.5770838261, green: 0.6604583859, blue: 0.7156390548, alpha: 1)))
            .cornerRadius(40)
            .shadow(radius: 4, x: 4, y: 4)
    }
}

struct TagStyle_Previews: PreviewProvider {
    static var previews: some View {
        Text("JavaScript")
            .modifier(TagStyle())
            .previewLayout(.fixed(width: 400, height: 200))
    }
}
