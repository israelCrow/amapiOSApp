//
//  VisualizePitchesConstants.swift
//  Amap
//
//  Created by Alejandro Aristi C on 9/8/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

class VisualizePitchesConstants {

  enum NoFilterResultsView {
    
    static let warningNoPitchesText = "No tenemos filtros\nque mostrarte"
    
  }
  
  enum NoPitchesAssignedView {
    
    static let warningNoPitchesText = "No tienes pitches\ncreados"
    static let navigationBarText = "Perfil agencia"
    static let rightButtonText = "Log out"
  
  }
  
  enum VisualizeAllPitchesViewController {
    
    static let navigationRightButtonText = "Info"
    static let navigationBarTitleText = "Pitches"
    
    static let navigationRightButtonWhenDetailPitchViewIsShownText = "Cerrar"
    
  }
  
  enum CreateAddNewPitchAndWriteBrandNameViewController {
    
    static let navigationRightButtonText = "Cerrar"
    static let navigationLeftButtonText = "Atrás"
    static let navigationBarTitleText = "Agregar Pitch"
    
  }
  
  enum AddPitchAndWriteCompanyNameView {
    
    static let writeCompanyNameLabelText = "Escribe el nombre del anunciante" //escribe el nombre de la compañía
    static let askPermissionLabelText = "Ningún anunciante registrado con ese nombre" //"No hay ningún anunciante registrado con ese nombre\n\n¿Desea agregarlo?"
    static let addButtonText = "agregar"
    
  }
  
  enum AddPitchAndWriteBrandNameView {
    
    static let writeBrandNameLabelText = "Escribe el nombre de la marca"
    static let askPermissionLabelText = "Ninguna marca registrada con ese nombre" //"No hay ninguna marca registrada con ese nombre\n\n¿Desea agregarla?"
    static let addButtonText = "agregar"
    
  }
  
  enum AddPitchAndWriteProjectNameView {
    
    static let writeProjectNameLabelText = "Escribe el nombre del proyecto"
    static let askPermissionLabelText = "Ningún proyecto está registrado con ese nombre" //"No hay ningún proyecto registrado con ese nombre\n\n¿Desea agregarla?"
    static let addButtonText = "agregar"
    
  }
  
  enum AddPitchAndWriteWhichCategoryIsView {
    
    static let writeWhichCategoryIsLabelText = "Escribe qué tipo\nde categoría es:"
//    static let askPermissionLabelText = "No hay ningún proyecto registrado con ese nombre\n\n¿Desea agregarla?"
    static let addButtonText = "agregar pitch"
    
  }
  
  enum PreEvaluatePitchViewController {
    
    static let navigationBarTitleText = "Agregar Pitch "
    
  }
  
  enum EvaluatePitchViewController {
    
    static let navigationBarTitleText = "Editar Pitch"
    
  }
  
  enum EditPitchEvaluationViewcontroller {
    
    static let navigationBarTitleText = "Editar Pitch"
    
  }
  
  enum PreEvaluatePitchView {
    
    static let descriptionWriteNameLabel =  "Escribe el e-mail del contacto que te brifeó"
    static let descriptionWriteDateLabel = "¿Qué día te dieron el brief?"
    static let nextButtonText = "agregar"
    
  }
  
  enum SuccessfullyCreationOfPitchView {
    
    static let readyLabelText = "¡Felicidades!"
    static let descriptionLabelText = "Tu pitch se ha dado de alta con éxito"
    static let nextButtonText = "evaluar pitch"
    
  }
  
  enum FilterPitchCardView {
    
    static let wonCriterionText = "Ganado"
    static let activeCriterionText = "Activo"
    static let archivedCriterionText = "Archivado"
    static let declinedCriterionText = "Declinado"
    static let canceledCriterionText = "Cancelado"
    
  }
  
  enum AddResultViewController {
    
    static let backButtonItemText = "Atrás"
    static let navigationBarTitleText = "Pitches"
    static let rightButtonItemText = "Cerrar"
    
  }
  
  enum PendingEvaluationCardView {
    
    static let pendingEvaluationLabelText = "¡Evaluación Pendiente!"
    static let nextButtonText = "evalúa"
    
  }
  
  enum YouWonThisPitchView {
    
    static let youWonThisPitchLabelText = "¡Ganaste!"
    static let detailedLabelText = "Queremos saber si tu proyecto se activó. Llena la siguiente encuesta para darle seguimiento."
    static let nextButtonText = "encuesta"
    
  }
  
  enum InfoPitchesViewAndViewController {
    
    static let navigationBarTitleText = "Info Happitch"
    static let rightButtonItemText = "Cerrar"
    
    static let evaluationLabelText = "Evaluación"
    static let faceOneLabelText = "70 - 100\nHappitch"
    static let faceTwoLabelText = "59 - 69\nHappy"
    static let faceThreeLabelText = "45 - 58\nUnhappy"  //Ok
    static let faceFourLabelText = "0 - 44\nBadpitch"  //Unhappy
    
    static let statisticsLabelText = "Estadísticas"
    static let descriptionStatisticsLabelTextForAgency = "HAPPITCH® es una herramienta que te permite visualizar tu rate de bateo, compararte con las demás agencias y contra la industria; evaluando tu desempeño en la participación de pitches."
    
    static let descriptionStatisticsLabelTextForCompany = "HAAPITCH® es una herramienta que te permite visualizar cómo las agencias que participan en tus diferentes pitches te evalúan, dejando ver lo que ellos necesitan vs. lo que están recibiendo."
    
    static let contactLabelText = "Contacto"
    static let mailLabelText = "amap@amap.com.mx"
    static let phoneLabelText = "+52 (55) 26230561"
    static let webSiteLabelText = "www.amap.com.mx"
    
    
  }
  
}
