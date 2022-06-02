//
//  BottomView.swift
//  FishApp-SwiftUI
//
//  Created by Hager Elsayed on 31/05/2022.
//

import SwiftUI

struct BottomView: View {
    var similarResults = ["fish1", "fish2", "fish3"]
    let columns = [
        GridItem(.adaptive(minimum: 80), spacing: 30)
    ]
    var body: some View {
        ScrollView {
            Image("fish")
                .padding()
            
            VStack(alignment: .leading) {
                Text("Recommended Tank Parameters:")
                    .fontWeight(.medium)
                    .font(.title2)
                    .foregroundColor(.fishAccentColor)
                    .padding()
                
                RowInfoView(title: "Temperature:", value: "75° - 86° F (24° - 30° C)")
                RowInfoView(title: "PH:", value: "7.0 - 8.5")
                RowInfoView(title: "KH:", value: "15 - 35 dKH")
                RowInfoView(title: "Minimum tank size:", value: "5 gallons")
                Text("Similar result:")
                    .fontWeight(.bold)
                    .font(.system(size: 16))
                    .foregroundColor(.fishBlackColor)
                    .padding(.horizontal, 20)
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 30) {
                        ForEach(similarResults, id: \.self) { item in
                            SimilarImageView(image: item)
                        }
                    }
                    .padding(.horizontal, 20)
                }
                
                
                
            }
        }
    }
}

struct SimilarImageView: View {
    var image: String
    var body: some View {
        HStack {
            Image(image)
                .padding()
            
        }
        .frame(width: 93, height: 114)
        .overlay(
        RoundedRectangle(cornerRadius: 24)
            .stroke(Color.gray, lineWidth: 1)
        )
    }
}
struct RowInfoView: View {
    var title: String
    var value: String
    var body: some View {
        HStack(spacing: 10) {
            Text(title)
                .fontWeight(.bold)
                .font(.system(size: 16))
                .foregroundColor(.fishBlackColor)
            Text(value)
                .fontWeight(.regular)
                .font(.title3)
                .foregroundColor(.fishGreyColor)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 6)
    }
}
struct BottomView_Previews: PreviewProvider {
    static var previews: some View {
        BottomView()
    }
}
