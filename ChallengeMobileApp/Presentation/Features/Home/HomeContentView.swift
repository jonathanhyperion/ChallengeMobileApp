//
//  HomeContentView.swift
//  ChallengeMobileApp
//

import SwiftUI
import Kingfisher

struct HomeContetView: View {
    @ObservedObject var viewModel: HomeViewModel
    @EnvironmentObject var surveyEnviroment: SurveyEnviroment
    @Binding var isMenuOpen: Bool
    @State private var isLastImage = false
    @State private var title = ""
    @State private var description = ""
    @State private var indexSurvey = 0
    
    let reader: CGSize
    var goToSurvey: () -> Void
    
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
                    if !Storage.shared.isTokenExpired() {
                        title = viewModel.surveys[indexSurvey].title
                        description = viewModel.surveys[indexSurvey].description
                    }
                }
                .onChange(of: viewModel.currentSurveyIndex) { newIndex in
                    title = viewModel.surveys[newIndex].title
                    description = viewModel.surveys[newIndex].description
                    indexSurvey = viewModel.currentSurveyIndex
                }
            }
            .isHidden(viewModel.isLoading)
            
            VStack {
                HStack {
                    VStack(alignment: .leading) {
                        Text(viewModel.todayDate().uppercased())
                            .font(.custom(FontFamily.Neuzeit.book, fixedSize: 13.0))
                            .redactShimmer(condition: viewModel.isLoading)
                        
                        Text(L10n.today.uppercased())
                            .font(.custom(FontFamily.Neuzeit.heavy, fixedSize: 34.0))
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
                        .font(.custom(FontFamily.Neuzeit.heavy, fixedSize: 28.0))
                        .redactShimmer(condition: viewModel.isLoading)
                    
                    HStack {
                        Text(description)
                            .font(.custom(FontFamily.Neuzeit.book, fixedSize: 17.0))
                            .redactShimmer(condition: viewModel.isLoading)
                        
                        Spacer()
                        
                        Button(action: {
                            // TODO: Navigation
                            surveyEnviroment.survey = viewModel.surveys[indexSurvey]
                            goToSurvey()
                            
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
