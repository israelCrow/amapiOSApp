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
    static let writeNameDescriptionText = "Escribe el nombre de la agencia o compañía"
    static let nameText = "Nombre"
    static let writeEMailDescriptioText = "Escribe tu mail"
    static let emailText = "Email"
    static let nextButtonText = "Pide tu contraseña"
  
    static let separationBetweenGoldenPitchStarAndGoldenPitchLabel = 10.0
    static let separationBetweenGoldenPitchStarAndAmap = 36.0
  
  }
  
  enum  SuccessfullyAskForAccountView {
    
    static let readyText = "¡Bravo!"
    static let successfullyMessageText = "Si tus datos son aprobados, en las próximas 48 horas recibirás tu password"
    static let nextButtonText = "Ok"
    
  }
  
  enum ExistingAccountView {
    
    static let oopsText = "¡Ouuh!"
    static let alreadyExistAgencyUser = "Ya existe un usuario\nde tu agencia registrado"
    static let alreadyExistCompanyUser = "Ya existe un usuario\nde tu compañía registrado"
    static let alreadyHaveAnAccount = "Al parecer ya tienes una cuenta"
    static let recommendationText = "Te recomendamos contactar al responsable para tener acceso"
    static let nextButtonText = "Ok"
    
  }
  
  enum CreateAccountProcessAlreadyBegunView {
    
    static let oopsText = "¡Ouuh!"
    static let alreadyBegunProcessText = "Ya existe una solicitud de creación de cuenta en proceso con este E-mail"
    static let nextButtonText = "Ok"
    
  }
  
}