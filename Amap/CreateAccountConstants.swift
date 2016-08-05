//
//  CreateAccountConstants.swift
//  Amap
//
//  Created by Alejandro Aristi C on 8/3/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import Foundation

class CreateAccountConstants {
  
  enum CreateAccountView{
  
    static let createAccountText = "Crea tu perfil"
    static let amapText = "AMAP"
    static let writeNameDescriptionText = "Escribe el nombre de la agencia o marca"
    static let nameText = "Nombre"
    static let writeEMailDescriptioText = "Escribe tu mail"
    static let emailText = "Email"
    static let nextButtonText = "solicitar contraseña"
  
    static let separationBetweenGoldenPitchStarAndGoldenPitchLabel = 10.0
    static let separationBetweenGoldenPitchStarAndAmap = 36.0
  
  }
  
  enum  SuccessfullyAskForAccountView {
    
    static let readyText = "¡Listo!"
    static let successfullyMessageText = "Si es aprobada se enviará una contraseña a tu mail en las próximas 48 horas."
    static let nextButtonText = "ok"
    
  }
  
  enum ExistingAccountView {
    
    static let oopsText = "¡Oops!"
    static let alreadyHaveAnAccount = "Al parecer ya tienes una cuenta."
    static let recommendationText = "Te recomendamos contactar al responsable para tener acceso."
    static let nextButtonText = "ok"
    
  }
  
  enum CreateAccountProcessAlreadyBegunView {
    
    static let oopsText = "¡Oops!"
    static let alreadyBegunProcessText = "Ya existe una solicitud de creación de cuenta en proceso con este E-mail."
    static let nextButtonText = "ok"
    
  }
  
}