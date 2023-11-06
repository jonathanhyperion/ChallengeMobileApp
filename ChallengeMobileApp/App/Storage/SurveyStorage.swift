//
//  SurveyStorage.swift
//  ChallengeMobileApp
//

import Foundation

final class SurveyStorage {
    
    static let shared = SurveyStorage()
    
    let surveyStorage = UserDefaults(suiteName: "survey")
    
    private enum Constants {
        static let survey = "survey"
        static let surveyList = "list"
    }
    
    func saveSurveyList(list: [SurveyItemList]) {
        do {
            let data = try JSONEncoder().encode(list)
            UserDefaults.standard.set(data, forKey: Constants.surveyList)
        } catch {
            print("Error for coding array structs: \(error.localizedDescription)")
        }
    }

    func getSurveyList() -> [SurveyItemList] {
        if let data = UserDefaults.standard.data(forKey: Constants.surveyList) {
                do {
                    let array = try JSONDecoder().decode([SurveyItemList].self, from: data)
                    return array
                } catch {
                    print("Error for coding array structs: \(error.localizedDescription)")
                }
            }
            return []
    }
    
    func saveSurvey(survey: SurveyItemList) {
        do {
            let data = try JSONEncoder().encode(survey)
            UserDefaults.standard.set(data, forKey: Constants.survey)
        } catch {
            print("Error for coding array structs: \(error.localizedDescription)")
        }
    }

    func getSurvey() -> SurveyItemList? {
        if let data = UserDefaults.standard.data(forKey: Constants.survey) {
                do {
                    let array = try JSONDecoder().decode(SurveyItemList.self, from: data)
                    return array
                } catch {
                    print("Error for coding array structs: \(error.localizedDescription)")
                }
            }
            return nil
    }
    
    func resetSurvey() {
        UserDefaults.standard.removeObject(forKey: Constants.survey)
    }
    
    func resetValues() {
        UserDefaults.standard.removePersistentDomain(forName: "survey")
    }
}
