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
            print("response- \(response)")
            if let data = data {
                print(data)
                
            }
        })
        task.resume()
        
    }
    
    func updateNote(noteInfo: NoteInfoApi) {
        
        
    }
    
    func delete(noteInfo: NoteInfoApi) {
        
    }
    
  
    
    func readListOfNotes(completion: @escaping ([NoteInfoApi]?, Error?) -> Void) {
        
    }
    
    
    
}
