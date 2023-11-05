//
//  HomeContentView.swift
//  ChallengeMobileApp
//

import SwiftUI
import Kingfisher

struct ImageModel {
    var id: Int
    var url: String
}

struct HomeContetView: View {
    @Binding var isMenuOpen: Bool
    @State private var isLastImage = false
    @State private var currentIndex: Int = 0
    
    let viewModel: HomeViewModel
    let reader: CGSize
    let images: [ImageModel] = [
        ImageModel(id: 1, url: "https://dhdbhh0jsld0o.cloudfront.net/m/1ea51560991bcb7d00d0_"),
        ImageModel(id: 2, url: "https://dhdbhh0jsld0o.cloudfront.net/m/287db81c5e4242412cc0_")
    ]
    
    var body: some View {
        ZStack {
            TabView(selection: $currentIndex) {
                ForEach(images.indices, id: \.self) { index in
                    KFImage(URL(string: images[index].url)!)
                        .resizable()
                        .scaledToFill()
                        .frame(
                            width: reader.width,
                            height: reader.height * 1.10
                        )
                        .clipped()
                        .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            
            VStack {
                HStack {
                    VStack(alignment: .leading) {
                        Text(viewModel.todayDate().uppercased())
                        Text(L10n.today.uppercased())
                    }
                    
                    Spacer()
                    
                    KFImage(URL(string: (viewModel.user.avatarURL ?? "")))
                        .resizable()
                        .frame(width: 35.0, height: 35.0)
                        .clipShape(Circle())
                        .shadow(radius: 5.0)
                        .onTapGesture {
                            isMenuOpen.toggle()
                        }
                }
                
                Spacer()
                
                VStack(alignment: .leading, spacing: 16.0) {
                    HStack(spacing: 8.0) {
                        ForEach(images.indices, id: \.self) { i in
                            Circle()
                                .frame(width: 10.0, height: 10.0)
                                .foregroundColor(i == self.currentIndex ? .white : .gray)
                                .onTapGesture {
                                    withAnimation {
                                        self.currentIndex = i
                                    }
                                }
                        }
                    }
                    Text("Working from home Check-In")
                    HStack {
                        Text("We would like to know how you feel about our work from home...")
                        
                        Spacer()
                        
                        Button(action: {
                            if currentIndex == images.count - 1 {
                                //TODO: Navigation
                            } else {
                                currentIndex += 1
                            }
                            isLastImage = currentIndex == images.count - 1
                        }, label: {
                            Asset.nextIcon.swiftUIImage
                                .resizable()
                                .frame(width: 25.0, height: 25.0)
                                .padding()
                                .background(.white)
                                .clipShape(Circle())
                        })

                    }
                }
            }
            .padding(.horizontal, 20.0)
            .frame(
                width: reader.width,
                height: reader.height * 0.80
            )
        }
        .foregroundColor(.white)
        .frame(
            width: reader.width,
            height: reader.height
        )
    }
}
