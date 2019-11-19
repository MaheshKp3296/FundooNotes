//
//  RESTNoteDataHelper.swift
//  Fundoo
//
//  Created by User on 15/11/19.
//  Copyright © 2019 BridgeLabz. All rights reserved.
//

import Foundation

class NoteNetworkManagar : RESTNoteModel {
    
    
    
    func addNotes(note: NoteInfoApi) {
        let url = URL(string: "http://fundoonotes.incubation.bridgelabz.com/api/notes/addNotes")
        let accessToken = "3g7HNkIm0CvG9uJaDbtlLIJTcznI1H48qa8gvuTFBmJ0rT21F2Asc740Ydx3HDzn"
        let httpHeaders = ["Content-Type": "application/json; charset= utf-8",
                           "Authorization": accessToken]
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "POST"
        do {
            let jsonBody = try JSONEncoder().encode(note)
            urlRequest.httpBody = jsonBody
        }
        catch{}
        urlRequest.allHTTPHeaderFields = httpHeaders
        let session = URLSession.shared
        let task = session.dataTask(with: urlRequest, completionHandler: {data , response,error -> Void in
            if let error = error {
                print(error.localizedDescription)
            }
            //    print("response- \(response)")
            if let data = data {
                print("Create note data - \(data)")
                
            }
        })
        task.resume()
        
    }
    
    typealias ResponseData = [NoteInfoApi]
    typealias ResponseError = Error
    
    func readListOfNotes(completion: @escaping (ResponseData?, ResponseError?) -> Void) {
        var NotesList = [NoteInfoApi]()
        let url = URL(string: "http://fundoonotes.incubation.bridgelabz.com/api/notes/getNotesList")
        let accessToken = "3g7HNkIm0CvG9uJaDbtlLIJTcznI1H48qa8gvuTFBmJ0rT21F2Asc740Ydx3HDzn"
        let httpHeader = ["Content-Type": "application/json; charset=utf-8", "Authorization" : accessToken ]
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "GET"
        urlRequest.allHTTPHeaderFields = httpHeader
        let task = URLSession.shared.dataTask(with: urlRequest, completionHandler: {data, response, error -> Void in
            if let error = error {
                completion(nil, error.localizedDescription as? Error)
            }
            print("GET Response-> \(response)")
            guard let data = data else {
                return
            }
            do {
                let dataReceived = try JSONDecoder().decode(NoteApi.self, from : data)
                let listOfNotes = dataReceived.data.data
                for notes in listOfNotes!{
                    let title = notes.title
                    let description = notes.description
                    let isPined = notes.isPined
                    let isArchived = notes.isArchived
                    let color = notes.color
                    var noteDetails = NoteInfoApi.init(title: title, description: description, isPined: isPined, isArchived: isArchived, color: color)
                    noteDetails.id = notes.id
                    NotesList.append(noteDetails)
                }
                completion(NotesList,nil)
            }
            catch let error {
                print(error.localizedDescription)
            }
        })
        task.resume()
        
    }
    
    func updateNote(noteInfo: NoteInfoApi) {
        //    let note : NoteInfoApi!
        
        let url = URL(string: "http://fundoonotes.incubation.bridgelabz.com/api/notes/updateNotes")
        let accessToken = "3g7HNkIm0CvG9uJaDbtlLIJTcznI1H48qa8gvuTFBmJ0rT21F2Asc740Ydx3HDzn"
        let httpHeaders = ["Content-Type": "application/json; charset= utf-8",
                           "Authorization": accessToken]
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "POST"
        
        let postString = self.getPostString(params: noteInfo.asDictionary)
        print(postString)
        //  let jsonBody = try postString.data(using: .utf8)
        urlRequest.httpBody = postString.data(using: .utf8)
        
        urlRequest.allHTTPHeaderFields = httpHeaders
        let session = URLSession.shared
        let task = session.dataTask(with: urlRequest, completionHandler: { data, response, error -> Void in
            
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            print(response)
            
            guard let data = data else { return }
            print(data)
            
            do{
                let dataReceived = try JSONDecoder().decode(NoteApi.self, from : data)
                print(dataReceived.data.message)
                
            }
            catch let error{
                print(error.localizedDescription)
            }
        })
        task.resume()
        
        
    }
    
    func delete(noteInfo: NoteInfoApi) {
        
    }
    
    func getPostString(params:[String:Any]) -> String
    {
        var data = [String]()
        for(key, value) in params
        {
            data.append(key + "=\(value)")
        }
        return data.map { String($0) }.joined(separator: "&")
    }
    
    
}
