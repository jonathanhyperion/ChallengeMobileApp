//
//  HomeContentView.swift
//  ChallengeMobileApp
//

import SwiftUI
import Kingfisher

struct HomeContetView: View {
    @ObservedObject var viewModel: HomeViewModel
    @Binding var isMenuOpen: Bool
    @State private var isLastImage = false
    @State private var title = ""
    @State private var description = ""
    
    let reader: CGSize
    
    var body: some View {
        ZStack {
            VStack {
                TabView(selection: Binding(
                    get: { viewModel.currentSurveyIndex },
                    set: { newValue in
                        viewModel.currentSurveyIndex = newValue
                    }
                )) {
                    ForEach(viewModel.surveys.indices, id: \.self) { index in
                        KFImage(URL(string: viewModel.surveys[index].imageUrl))
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
                .onAppear {
                    title = viewModel.surveys[0].title
                    description = viewModel.surveys[0].description
                }
                .onChange(of: viewModel.currentSurveyIndex) { newIndex in
                    title = viewModel.surveys[newIndex].title
                    description = viewModel.surveys[newIndex].description
                }
            }
            .isHidden(viewModel.isLoading)
            
            VStack {
                HStack {
                    VStack(alignment: .leading) {
                        Text(viewModel.todayDate().uppercased())
                            .redactShimmer(condition: viewModel.isLoading)
                        
                        Text(L10n.today.uppercased())
                            .redactShimmer(condition: viewModel.isLoading)
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
                        .redactShimmer(condition: viewModel.isLoading)
                }
                
                Spacer()
                
                VStack(alignment: .leading, spacing: 16.0) {
                    HStack(spacing: 8.0) {
                        ForEach(viewModel.surveys.indices, id: \.self) { i in
                            Circle()
                                .frame(width: 10.0, height: 10.0)
                                .foregroundColor(i == self.viewModel.currentSurveyIndex ? .white : .gray)
                                .onTapGesture {
                                    withAnimation {
                                        self.viewModel.currentSurveyIndex = i
                                    }
                                }
                        }
                    }
                    .redactShimmer(condition: viewModel.isLoading)
                    
                    Text(title)
                        .redactShimmer(condition: viewModel.isLoading)
                    
                    HStack {
                        Text(description)
                            .redactShimmer(condition: viewModel.isLoading)
                        
                        Spacer()
                        
                        Button(action: {
                            if self.viewModel.currentSurveyIndex == self.viewModel.surveys.count - 1 {
                                // TODO: Navigation
                            } else {
                                self.viewModel.currentSurveyIndex += 1
                            }
                            self.isLastImage = self.viewModel.currentSurveyIndex == self.viewModel.surveys.count - 1
                        }, label: {
                            Asset.nextIcon.swiftUIImage
                                .resizable()
                                .frame(width: 25.0, height: 25.0)
                                .padding()
                                .background(.white)
                                .clipShape(Circle())
                        })
                        .isHidden(viewModel.isLoading)
                    }
                }
            }
            .padding(.horizontal, 20.0)
            .frame(
                width: reader.width,
                height: reader.height * 0.80
            )
        }
        .disabled(viewModel.isLoading)
        .background(.black)
        .foregroundColor(.white)
        .frame(
            width: reader.width,
            height: reader.height
        )
    }
}
