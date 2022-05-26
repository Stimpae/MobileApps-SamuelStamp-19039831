//
//  UserViewModel.swift
//  Foodie
//
//  Created by Samuel Stamp on 23/05/2022.
//

// Sourced from 
import Foundation

struct UserViewModel{
    
    var username: String = ""
    var email: String = ""
    var password: String = ""
    var confirmedPassword: String = ""
    var fullname: String = ""
    
    //MARK: - Check Functions
    
    public func passwordsMatch(confirmedpass: String) -> Bool {
        return confirmedpass == password
    }
    
    public func isEmpty(field: String) -> Bool {
        return field.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    public func isEmailValid(email: String) -> Bool {
        let emailTest = NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}")
        return emailTest.evaluate(with: email)
    }
    
    public func isPasswordValid(password: String) -> Bool {
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$")
        return passwordTest.evaluate(with: password)
    }
    
    //MARK: - Computed Properties
    
    public var isSignInComplete: Bool {
        if !isEmailValid(email: email) || isEmpty(field: fullname) || !isPasswordValid(password: password) || !passwordsMatch(confirmedpass: confirmedPassword)
        {
            return false
        }
        return true
    }
    
    public var isLogInComplete: Bool {
        if isEmpty(field: email) || isEmpty(field: password)
        {
            return false
        }
        
        return true
    }
    
    // MARK: - Failure Strings
    
    public var validNameText: String{
        if !isEmpty(field: fullname){
            return ""
        } else{
            return "Please enter your full name."
        }
    }
    
    public var validEmailText: String{
        if isEmailValid(email: email){
            return ""
        } else{
            return "Please enter a valid email address."
        }
    }
    
    public var validPasswordText: String{
        if isPasswordValid(password: password){
            return ""
        } else{
            return "Password must be 8 characters containing at least one number and one capital letter."
        }
    }
    
    public var validConfirmPassword: String{
        if passwordsMatch(confirmedpass: confirmedPassword){
            return ""
        } else{
            return "Password fields do not match"
        }
    }
    
}
