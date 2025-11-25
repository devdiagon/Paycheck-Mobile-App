# 📱 Paycheck Mobile App
**Gestión de Operarios, Aumentos y Registros – Flutter + Provider + Clean Architecture**

Este proyecto es una aplicación móvil desarrollada en **Flutter**, enfocada en gestionar **operarios**, calcular automáticamente sus aumentos salariales según su antigüedad y mantener un historial de registros.

## Tecnologías Utilizadas
- **Flutter 3.x**
- **Dart**
- **Provider** para manejo de estado
- **Arquitectura limpia (Domain / UseCases / ViewModels / UI)**
- Widgets personalizados y formularios con validaciones

---


---

## Lógica del Negocio

### ✔ Cálculo de aumento (UseCase `CalcularAumento`)
El aumento se calcula según:
- Sueldo actual
- Años de antigüedad del operario

Cada vez que:
- Se crea un operario → se genera **su primer registro automático**
- Se registra un nuevo aumento → se recalcula y se añade al historial

---

## Características del ViewModel
- Manejo reactivo con `ChangeNotifier`
- Lista centralizada de operarios
- Cada operario mantiene:
    - Su historial de aumentos (`List<AumentoRecord>`)
    - Su salario vigente
    - Su antigüedad actual

---

##  Principales Funcionalidades de la App

###  Registrar Operario
Formulario donde puedes ingresar:
- Nombre
- Sueldo inicial
- Antigüedad (con slider de 1 a 10)
- Fecha de ingreso

Al guardar:
✔ Se crea el operario  
✔ Se registra automáticamente su primer `AumentoRecord`  
✔ Se calcula el aumento inicial

---

### Registrar un Nuevo Aumento
El usuario puede:
- Modificar la antigüedad
- Registrar nuevo aumento  
  ✔ Se calcula el incremento  
  ✔ Se actualiza el salario  
  ✔ Se agrega un registro histórico

---

### Ver Historial Completo
Cada operario tiene una lista de:
- Salario anterior
- Salario nuevo
- Antigüedad anterior/nueva
- Fecha del aumento

---

