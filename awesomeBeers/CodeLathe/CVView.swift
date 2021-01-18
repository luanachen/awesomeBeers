//
//  CVView.swift
//  awesomeBeers
//
//  Created by Luana Chen Chih Jun on 15/01/21.
//  Copyright © 2021 Luana Chen. All rights reserved.
//

import SwiftUI

struct CVView: View {

    @ObservedObject var viewModel: CVViewViewModel

    private let skillRows = Array(repeating: GridItem(.flexible(), spacing: 20), count: 2)
    private let galleryRows = [GridItem(.fixed(95))]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                HStack {
                    Spacer()
                    HStack() {
                        HStack(spacing: 19) {
                            Image(uiImage: viewModel.image ?? UIImage())
                                .background(Color.black)
                                .frame(width: 42, height: 42)
                                .clipShape(Circle())
                            Text("John Doe")
                                .font(.title)
                        }
                        Spacer()
                        Divider()
                            .background(Color(#colorLiteral(red: 0.5770838261, green: 0.6604583859, blue: 0.7156390548, alpha: 1)))
                        Spacer()
                        VStack(spacing: 15) {
                            Text("@  john@doe.com")
                            Text("📞  john@doe.com")
                        }
                    }
                    Spacer()
                }
                .padding(.all)

                Text("Skills")
                    .font(.title)
                    .padding(.all)

                VStack {
                    LazyHGrid(rows: skillRows, spacing: 8) {
                        ForEach(viewModel.skills, id: \.self) {
                            Text("\($0)")
                                .fontWeight(.bold)
                                .modifier(TagStyle())
                        }
                    }
                }
                .padding(.leading)

                Text("Bio")
                    .font(.title)
                    .padding(EdgeInsets(top: 23, leading: 16, bottom: 16, trailing: 16))

                Text("\"John Doe\" and \"Jane Doe\" (for females) are multiple-use names that are used when the true name of a person is unknown or is being intentionally concealed. In the context of law enforcement in the United States, such names are often used to refer to a corpse whose identity is unknown or unconfirmed. Secondly, such names are also often used to refer to a hypothetical \"everyman\" in other contexts, in a manner similar to \"John Q. Public\" or \"Joe Public\". There are many variants to the above names, including \"John Roe\", \"Richard Roe\", \"Jane Roe\" and \"Baby Doe\", \"Janie Doe\" or \"Johnny Doe\" (for children).")
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(EdgeInsets(top: 0, leading: 16, bottom: 16, trailing: 16))

                Text("Gallery")
                    .font(.title)
                    .padding(.all)

                ScrollView(.horizontal) {
                    LazyHGrid(rows: galleryRows, spacing: 16) {
                        ForEach(viewModel.gallery, id: \.self) { item in
                            Image("\(item)")
                                .frame(width: 95, height: 93, alignment: .center)
                                .cornerRadius(5)
                                .clipped()
                                .overlay(RoundedRectangle(cornerRadius: 5)
                                            .stroke(Color(#colorLiteral(red: 0.5770838261, green: 0.6604583859, blue: 0.7156390548, alpha: 1)), lineWidth: 2)
                                            .shadow(radius: 2, x: 0, y: 1))

                        }
                    }
                }
                .padding(EdgeInsets(top: 0, leading: -16, bottom: 90, trailing: -16))
            }
        }
    }
}

struct CVView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            let viewModel = CVViewViewModel()
            CVView(viewModel: viewModel)
            CVView(viewModel: viewModel)
                .previewDevice("iPhone 12 mini")
        }
    }
}
