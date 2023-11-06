//
//  SurveyView.swift
//  ChallengeMobileApp
//

import SwiftUI
import Kingfisher

struct SurveyView: View {
    @EnvironmentObject var surveyEnviroment: SurveyEnviroment
    
    var goToBack: () -> Void
    
    var body: some View {
        GeometryReader { reader in
            ZStack {
                KFImage(URL(string: surveyEnviroment.survey?.imageUrl ?? ""))
                    .resizable()
                    .scaledToFill()
                    .frame(
                        width: reader.size.width,
                        height: reader.size.height
                    )
                    .edgesIgnoringSafeArea(.all)
                    .clipped()
                
                VStack(alignment: .leading) {
                    Asset.backIcon.swiftUIImage
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40.0, height: 40.0)
                        .onTapGesture {
                            goToBack()
                            surveyEnviroment.resetValues()
                        }
                    VStack(alignment: .leading, spacing: 16.0) {
                        Text(surveyEnviroment.survey?.title ?? "")
                            .font(.custom(FontFamily.Neuzeit.heavy, fixedSize: 34.0))
                        Text(surveyEnviroment.survey?.description ?? "")
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
                                    Text("Start Survey")
                                        .font(.custom(FontFamily.Neuzeit.heavy, fixedSize: 17.0))
                                        .foregroundColor(.black)
                                        .padding()
                                }
                                .frame(width: 140, height: 60, alignment: .bottomTrailing)
                                .background(.white)
                                .cornerRadius(10)
                            })
                    }
                }
                .padding(20.0)
                .frame(width: reader.size.width, height: reader.size.height * 0.85)
            }
        }
        .background(.black)
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea()
        .background()
    }
}

struct SurveyView_Previews: PreviewProvider {
    static var previews: some View {
        SurveyView(goToBack: {})
    }
}
