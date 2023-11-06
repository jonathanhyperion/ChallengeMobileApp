//
//  SurveyView.swift
//  ChallengeMobileApp
//

import SwiftUI
import Kingfisher

struct SurveyView: View {
    var goToBack: () -> Void
    
    var body: some View {
        GeometryReader { reader in
            ZStack {
                KFImage(URL(string: SurveyStorage.shared.getSurvey()?.imageUrl ?? ""))
                    .resizable()
                    .scaledToFill()
                    .frame(
                        width: reader.size.width,
                        height: reader.size.height
                    )
                    .edgesIgnoringSafeArea(.all)
                    .clipped()
                    .overlay {
                        Rectangle()
                        .foregroundColor(.clear)
                        .frame(
                            width: reader.size.width,
                            height: reader.size.height
                        )
                        .background(
                            LinearGradient(
                                gradient: Gradient(colors: [.black.opacity(0.3), .black.opacity(0.3)]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                    }
                
                VStack(alignment: .leading) {
                    Asset.backIcon.swiftUIImage
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40.0, height: 40.0)
                        .onTapGesture {
                            goToBack()
                            SurveyStorage.shared.resetSurvey()
                        }
                    VStack(alignment: .leading, spacing: 16.0) {
                        Text(SurveyStorage.shared.getSurvey()?.title ?? "")
                            .font(.custom(FontFamily.Neuzeit.heavy, fixedSize: 34.0))
                        
                        Text(SurveyStorage.shared.getSurvey()?.description ?? "")
                            .font(.custom(FontFamily.Neuzeit.heavy, fixedSize: 17.0))
                    }
                    .foregroundColor(.white)
                    
                    Spacer()
                    
                    HStack {
                        Spacer()
                        Button(
                            action: {
                                //TODO: Action navigate to start survey
                            }, label: {
                                VStack {
                                    Text(L10n.startSurvey)
                                        .font(.custom(FontFamily.Neuzeit.heavy, fixedSize: 17.0))
                                        .foregroundColor(.black)
                                        .padding()
                                }
                                .frame(width: 140, height: 60, alignment: .center)
                                .background(.white)
                                .cornerRadius(10)
                            })
                    }
                }
                .padding(20.0)
                .frame(width: reader.size.width, height: reader.size.height * 0.85)
            }
        }
        .ignoresSafeArea()
        .background(.black)
        .navigationBarBackButtonHidden(true)
    }
}

struct SurveyView_Previews: PreviewProvider {
    static var previews: some View {
        SurveyView(goToBack: {})
    }
}
