//
//  SideNav.swift
//  ChallengeMobileApp
//

import SwiftUI
import Kingfisher

struct SideNav: View {
    @EnvironmentObject var surveyEnviroment: SurveyEnviroment
    let reader: CGSize
    let user: UserProfile
    var goToLogin: () -> Void
    var LogoutAction: () -> Void
    var body: some View {
        HStack {
            Spacer()
            VStack {
                VStack(alignment: .leading) {
                    HStack {
                        Text(user.name ?? "")
                            .font(.custom(FontFamily.Neuzeit.heavy, fixedSize: 34.0))
                            .foregroundColor(.white)
                        
                        Spacer()
                        
                        KFImage(URL(string: (user.avatarURL ?? "")))
                            .resizable()
                            .frame(width: 35.0, height: 35.0)
                            .clipShape(Circle())
                            .shadow(radius: 5.0)
                    }
                    .padding(.vertical, 20.0)
                    
                    Divider()
                        .background(.white)
                    
                    Button(
                        action: {
                            surveyEnviroment.resetValues()
                            surveyEnviroment.reset()
                            LogoutAction()
                            goToLogin()
                        }, label: {
                            Text("Logout")
                                .font(.custom(FontFamily.Neuzeit.heavy, fixedSize: 20.0))
                                .kerning(0.38)
                                .foregroundColor(.white)
                                .multilineTextAlignment(.leading)
                                .padding(.vertical, 16.0)
                        }
                    )
                    
                    Spacer()
                }
                .padding(.horizontal, 20.0)
                .frame(
                    width: reader.width * 0.65,
                    height: reader.height * 0.80
                )
                
                Text("v0.1.0 (1562903885)")
                    .font(.custom(FontFamily.Neuzeit.heavy, fixedSize: 11.0))
                    .kerning(0.07)
                    .foregroundColor(.white)
                    .frame(width: 200.0, alignment: .topLeading)
            }
            .frame(
                width: reader.width * 0.65,
                height: reader.height
            )
            .background(Asset.darkGray.swiftUIColor)
        }
    }
}
