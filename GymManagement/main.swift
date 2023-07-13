//
//  main.swift
//  GymManagement
//
//  Created by Ricardo Lourenço on 13/07/2023.
//

import Foundation

let storagePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
let credentialsFileURL = storagePath.appendingPathComponent("credenciais.txt")
let membersFileURL = storagePath.appendingPathComponent("membros.txt")
let trainersFileURL = storagePath.appendingPathComponent("PTs.txt")
let schedulesFileURL = storagePath.appendingPathComponent("horarios.txt")
let workoutplansFileURL = storagePath.appendingPathComponent("planos_treino.txt")
let aloneclassesFileURL = storagePath.appendingPathComponent("aulas_individuais.txt")
let groupclassesFileURL = storagePath.appendingPathComponent("aulas_grupo.txt")
func saveCredentials(username: String, password: String)
{
    let credentials = "\(username),\(password)\n"
    if let data = credentials.data(using: .utf8)
    {
        if FileManager.default.fileExists(atPath: credentialsFileURL.path)
        {
            if let fileHandle = try? FileHandle(forWritingTo: credentialsFileURL)
            {
                fileHandle.seekToEndOfFile()
                fileHandle.write(data)
                fileHandle.closeFile()
            }
        }
        else
        {
            try? credentials.write(to: credentialsFileURL, atomically: true, encoding: .utf8)
        }
    }
}
func validateCredentials(username: String, password: String) -> Bool
{
    do
    {
        let credentialsData = try Data(contentsOf: credentialsFileURL)
        if let credentialsString = String(data: credentialsData, encoding: .utf8)
        {
            let credentialsArray = credentialsString.components(separatedBy: .newlines)
            for credential in credentialsArray
            {
                let components = credential.components(separatedBy: ",")
                if components.count == 2 && components[0] == username && components[1] == password
                {
                    return true
                }
            }
        }
    }
    catch
    {
        print("Erro ao ler o ficheiro: \(error)")
    }
    return false
}
func saveMembers(name: String, age: String)
{
    let values = "\(name),\(age)\n"
    if let data = values.data(using: .utf8)
    {
        if FileManager.default.fileExists(atPath: membersFileURL.path)
        {
            if let fileHandle = try? FileHandle(forWritingTo: membersFileURL)
            {
                fileHandle.seekToEndOfFile()
                fileHandle.write(data)
                fileHandle.closeFile()
            }
        }
        else
        {
            try? values.write(to: membersFileURL, atomically: true, encoding: .utf8)
        }
    }
}
func saveTrainers(name: String, specialty: String)
{
    let values = "\(name),\(specialty)\n"
    if let data = values.data(using: .utf8)
    {
        if FileManager.default.fileExists(atPath: trainersFileURL.path)
        {
            if let fileHandle = try? FileHandle(forWritingTo: trainersFileURL)
            {
                fileHandle.seekToEndOfFile()
                fileHandle.write(data)
                fileHandle.closeFile()
            }
        }
        else
        {
            try? values.write(to: trainersFileURL, atomically: true, encoding: .utf8)
        }
    }
}
func saveSchedules(day: String, hour: String)
{
    let values = "\(day),\(hour)\n"
    if let data = values.data(using: .utf8)
    {
        if FileManager.default.fileExists(atPath: schedulesFileURL.path)
        {
            if let fileHandle = try? FileHandle(forWritingTo: schedulesFileURL)
            {
                fileHandle.seekToEndOfFile()
                fileHandle.write(data)
                fileHandle.closeFile()
            }
        }
        else
        {
            try? values.write(to: schedulesFileURL, atomically: true, encoding: .utf8)
        }
    }
}
func saveWorkoutPlans(name: String, duration: String, workouts: [String])
{
    let values = "\(name),\(duration),\(workouts)\n"
    if let data = values.data(using: .utf8)
    {
        if FileManager.default.fileExists(atPath: workoutplansFileURL.path)
        {
            if let fileHandle = try? FileHandle(forWritingTo: workoutplansFileURL)
            {
                fileHandle.seekToEndOfFile()
                fileHandle.write(data)
                fileHandle.closeFile()
            }
        }
        else
        {
            try? values.write(to: workoutplansFileURL, atomically: true, encoding: .utf8)
        }
    }
}
func saveAloneClasses(id: Int, name: String, duration: String, trainer: String)
{
    let values = "Aula \(id), Membro: \(name), Duração: \(duration), PT:\(trainer)\n"
    if let data = values.data(using: .utf8)
    {
        if FileManager.default.fileExists(atPath: aloneclassesFileURL.path)
        {
            if let fileHandle = try? FileHandle(forWritingTo: aloneclassesFileURL)
            {
                fileHandle.seekToEndOfFile()
                fileHandle.write(data)
                fileHandle.closeFile()
            }
        }
        else
        {
            try? values.write(to: aloneclassesFileURL, atomically: true, encoding: .utf8)
        }
    }
}
func saveGroupClasses(id: Int, name: [String], duration: String, trainer: String)
{
    let values = "Aula \(id), Membros: \(name), Duração: \(duration), PT:\(trainer)\n"
    if let data = values.data(using: .utf8)
    {
        if FileManager.default.fileExists(atPath: groupclassesFileURL.path)
        {
            if let fileHandle = try? FileHandle(forWritingTo: groupclassesFileURL)
            {
                fileHandle.seekToEndOfFile()
                fileHandle.write(data)
                fileHandle.closeFile()
            }
        }
        else
        {
            try? values.write(to: groupclassesFileURL, atomically: true, encoding: .utf8)
        }
    }
}
func updateAloneClasses(id: Int)
{
    do
    {
        var contents = try String(contentsOfFile: aloneclassesFileURL.path, encoding: .utf8)
        var lines = contents.components(separatedBy: .newlines)
        var index = 0
        var Updated = false
        while index < lines.count
        {
            let lineComponents = lines[index].components(separatedBy: ",")
            if let lineID = lineComponents.first, lineID == "Aula \(id)"
            {
                listMembers()
                print("Escreva o nome do Membro que irá participar na aula: ")
                let name = readLine()
                print("Insira a duração da aula: ")
                let duration = readLine()
                listTrainers()
                print("Escreva o nome do PT que irá dar a aula: ")
                let trainer = readLine()
                let updatedLine = "Aula \(id), Membro: \(String(describing: name)), Duração: \(String(describing: duration)), PT:\(String(describing: trainer))\n"
                lines[index] = updatedLine
                Updated = true
                break
            }
            index += 1
        }
        
        if Updated
        {
            contents = lines.joined(separator: "\n")
            try contents.write(toFile: aloneclassesFileURL.path, atomically: true, encoding: .utf8)
            print("Aula \(id) atualizada com sucesso.")
        }
        else
        {
            print("Aula \(id) não encontrada.")
        }
    }
    catch
    {
        print("Erro ao aceder ao ficheiro: \(error)")
    }
}
func deleteAloneClasses(id: Int)
{
    do
    {
        var contents = try String(contentsOfFile: aloneclassesFileURL.path, encoding: .utf8)
        var lines = contents.components(separatedBy: .newlines)
        var index = 0
        var Deleted = false
        while index < lines.count
        {
            let lineComponents = lines[index].components(separatedBy: ",")
            if let lineID = lineComponents.first, lineID == "Aula \(id)"
            {
                lines.remove(at: index)
                Deleted = true
                break
            }
            index += 1
        }
        
        if Deleted
        {
            contents = lines.joined(separator: "\n")
            try contents.write(toFile: aloneclassesFileURL.path, atomically: true, encoding: .utf8)
            print("Aula \(id) eliminada com sucesso.")
        }
        else
        {
            print("Aula \(id) não encontrada.")
        }
    }
    catch
    {
        print("Erro ao aceder ao ficheiro: \(error)")
    }
}
func updateGroupClasses(id: Int)
{
    do
    {
        var contents = try String(contentsOfFile: groupclassesFileURL.path, encoding: .utf8)
        var lines = contents.components(separatedBy: .newlines)
        var index = 0
        var Updated = false
        while index < lines.count
        {
            let lineComponents = lines[index].components(separatedBy: ",")
            if let lineID = lineComponents.first, lineID == "Aula \(id)"
            {
                var members = [String]()
                listMembers()
                var continueAddingMembers = true
                while continueAddingMembers == true
                {
                    print("Escreva o nome dos Membros que irão participar na aula(ou 'feito' para parar de adicionar membros): ")
                    let name = readLine() ?? ""
                    if name.lowercased() == "feito"
                    {
                        continueAddingMembers = false
                    }
                    else
                    {
                        members.append(name)
                    }
                }
                print("Insira a duração da aula: ")
                let duration = readLine()
                listTrainers()
                print("Escreva o nome do PT que irá dar a aula: ")
                let trainer = readLine()
                let updatedLine = "Aula \(id), Membros: \(members), Duração: \(String(describing: duration)), PT:\(String(describing: trainer))\n"
                lines[index] = updatedLine
                Updated = true
                break
            }
            index += 1
        }
        
        if Updated
        {
            contents = lines.joined(separator: "\n")
            try contents.write(toFile: groupclassesFileURL.path, atomically: true, encoding: .utf8)
            print("Aula \(id) atualizada com sucesso.")
        }
        else
        {
            print("Aula \(id) não encontrada.")
        }
    }
    catch
    {
        print("Erro ao aceder ao ficheiro: \(error)")
    }
}
func deleteGroupClasses(id:Int)
{
    do
    {
        var contents = try String(contentsOfFile: groupclassesFileURL.path, encoding: .utf8)
        var lines = contents.components(separatedBy: .newlines)
        var index = 0
        var Deleted = false
        while index < lines.count
        {
            let lineComponents = lines[index].components(separatedBy: ",")
            if let lineID = lineComponents.first, lineID == "Aula \(id)"
            {
                lines.remove(at: index)
                Deleted = true
                break
            }
            index += 1
        }
        
        if Deleted
        {
            contents = lines.joined(separator: "\n")
            try contents.write(toFile: groupclassesFileURL.path, atomically: true, encoding: .utf8)
            print("Aula \(id) eliminada com sucesso.")
        }
        else
        {
            print("Aula \(id) não encontrada.")
        }
    }
    catch
    {
        print("Erro ao aceder ao ficheiro: \(error)")
    }
}
if FileManager.default.fileExists(atPath: credentialsFileURL.path) == false
{
    saveCredentials(username: "admin", password: "123")
}
if FileManager.default.fileExists(atPath: membersFileURL.path) == false
{
    saveMembers(name: "João Silva", age: "30")
    saveMembers(name: "Joana Gonçalves", age: "25")
}
if FileManager.default.fileExists(atPath: trainersFileURL.path) == false
{
    saveTrainers(name: "João Barros", specialty: "Levantamento de Peso")
    saveTrainers(name: "Sofia Castro", specialty: "Yoga")
}
func register()
{
    print("Insira o seu nome de utilizador: ")
    let username = readLine()
    print("Insira a sua palavra-passe: ")
    let password = readLine()
    saveCredentials(username: username!, password: password!)
    print("Registo efetuado com sucesso!")
    print("")
}
func login() -> Int
{
    print("Insira o seu nome de utilizador: ")
    let username = readLine()
    print("Insira a sua palavra-passe: ")
    let password = readLine()
    if validateCredentials(username: username!, password: password!)
    {
        print("Login efetuado com sucesso!")
        print("")
        return 3;
    }
    else
    {
        print("Credenciais inválidas!")
        print("")
        return 1;
    }
}
func registerMembers()
{
    print("Insira o nome do membro: ")
    let name = readLine()
    print("Insira a idade do membro: ")
    let age = readLine()
    saveMembers(name: name!, age: age!)
    print("Membro adicionado com sucesso!")
    print("")
}
func listMembers()
{
    do
    {
        let contents = try String(contentsOfFile: membersFileURL.path, encoding: .utf8)
        let entries = contents.components(separatedBy: .newlines)
        for entry in entries
        {
            print(entry)
        }
        print("")
    }
    catch
    {
        print("Erro ao ler o ficheiro: \(error)")
    }
}
func registerTrainers()
{
    print("Insira o nome do PT: ")
    let name = readLine()
    print("Insira a especialidade do PT: ")
    let specialty = readLine()
    saveTrainers(name: name!, specialty: specialty!)
    print("PT adicionado com sucesso!")
    print("")
}
func listTrainers()
{
    do
    {
        let contents = try String(contentsOfFile: trainersFileURL.path, encoding: .utf8)
        let entries = contents.components(separatedBy: .newlines)
        for entry in entries
        {
            print(entry)
        }
        print("")
    }
    catch
    {
        print("Erro ao ler o ficheiro: \(error)")
    }
}
func registerSchedules()
{
    print("Insira o dia da semana: ")
    let day = readLine()
    print("Insira a hora: ")
    let hour = readLine()
    saveSchedules(day: day!, hour: hour!)
    print("Horário adicionado com sucesso!")
    print("")
}
func listSchedules()
{
    do
    {
        let contents = try String(contentsOfFile: schedulesFileURL.path, encoding: .utf8)
        let entries = contents.components(separatedBy: .newlines)
        for entry in entries
        {
            print(entry)
        }
        print("")
    }
    catch
    {
        print("Erro ao ler o ficheiro: \(error)")
    }
}
func registerWorkoutPlans()
{
    var workouts = [String]()
    print("Insira o nome do plano de treino: ")
    let name = readLine()
    print("Insira a duração do plano de treino: ")
    let duration = readLine()
    var continueAddingWorkouts = true
    while continueAddingWorkouts == true
    {
    print("Insira o exercício do plano de treino(ou 'feito' para parar de adicionar exercícios): ")
    let workout = readLine() ?? ""
    if workout.lowercased() == "feito"
    {
        continueAddingWorkouts = false
    }
    else
    {
        workouts.append(workout)
    }
    }
    saveWorkoutPlans(name: name!, duration: duration!, workouts: workouts)
    print("Plano de treino adicionado com sucesso!")
    print("")
}
func listWorkoutPlans()
{
    do
    {
        let contents = try String(contentsOfFile: workoutplansFileURL.path, encoding: .utf8)
        let entries = contents.components(separatedBy: .newlines)
        for entry in entries
        {
            print(entry)
        }
        print("")
    }
    catch
    {
        print("Erro ao ler o ficheiro: \(error)")
    }
}
func countLines(path: String) -> Int
{
    do
    {
        let contents = try String(contentsOfFile: path, encoding: .utf8)
        let entries = contents.components(separatedBy: .newlines)
        return entries.count
    }
    catch
    {
        print("Erro ao ler o ficheiro: \(error)")
    }
    return 0
}
func registerAloneClasses()
{
    listMembers()
    print("Escreva o nome do Membro que irá participar na aula: ")
    let name = readLine()
    print("Insira a duração da aula: ")
    let duration = readLine()
    listTrainers()
    print("Escreva o nome do PT que irá dar a aula: ")
    let trainer = readLine()
    saveAloneClasses(id: countLines(path: aloneclassesFileURL.path)+1, name: name!, duration: duration!, trainer: trainer!)
    print("Aula adicionada com sucesso!")
    print("")
}
func listAloneClasses()
{
    do
    {
        let contents = try String(contentsOfFile: aloneclassesFileURL.path, encoding: .utf8)
        let entries = contents.components(separatedBy: .newlines)
        for entry in entries
        {
            print(entry)
        }
        print("")
    }
    catch
    {
        print("Erro ao ler o ficheiro: \(error)")
    }
}
func registerGroupClasses()
{
    var members = [String]()
    listMembers()
    var continueAddingMembers = true
    while continueAddingMembers == true
    {
    print("Escreva o nome dos Membros que irão participar na aula(ou 'feito' para parar de adicionar membros): ")
    let name = readLine() ?? ""
    if name.lowercased() == "feito"
    {
        continueAddingMembers = false
    }
    else
    {
        members.append(name)
    }
    }
    print("Insira a duração da aula: ")
    let duration = readLine()
    listTrainers()
    print("Escreva o nome do PT que irá dar a aula: ")
    let trainer = readLine()
    saveGroupClasses(id: countLines(path: groupclassesFileURL.path)+1, name: members, duration: duration!, trainer: trainer!)
    print("Aula adicionada com sucesso!")
    print("")
}
func listGroupClasses()
{
    do
    {
        let contents = try String(contentsOfFile: groupclassesFileURL.path, encoding: .utf8)
        let entries = contents.components(separatedBy: .newlines)
        for entry in entries
        {
            print(entry)
        }
        print("")
    }
    catch
    {
        print("Erro ao ler o ficheiro: \(error)")
    }
}

var option = 1
var option2 = 1
while(option != 0 && option != 3)
{
    print("Para registar prima 1. Para fazer login prima 2. Para sair prima 0")
    let input = readLine()
    option = Int(input!)!
    if(option != 0)
    {
        switch (option)
        {
            case 1:
            register()
            print("")
            break;
            case 2:
            option = login()
            print("")
            break;
            default:
            print("Opção inválida!")
            print("")
            break;
        }
    }
    else
    {
        exit(0)
    }
}
print("Bem vindo ao ginásio!")
while(option2 != 0)
{
    print("Para inserir um novo membro prima 1. Para inserir um novo PT prima 2")
    print("Para visualizar os membros prima 3. Para visualizar os PTs prima 4")
    print("Para inserir um novo horario prima 5. Para visualizar os horarios prima 6")
    print("Para inserir um novo plano de treino prima 7. Para visualizar os planos de treino prima 8")
    print("Para inserir uma nova aula individual prima 9. Para visualizar as aulas individuais prima 10")
    print("Para inserir uma nova aula de grupo prima 11. Para visualizar as aulas de grupo prima 12")
    print("Para atualizar uma aula individual prima 13. Para atualizar uma aula de grupo prima 14")
    print("Para eliminar uma aula individual prima 15. Para eliminar uma aula de grupo prima 16")
    print("Para sair prima 0")
    let input = readLine()
    option2 = Int(input!)!
    if(option2 != 0)
    {
        switch (option2)
        {
            case 1:
            registerMembers()
            break;
            case 2:
            registerTrainers()
            break;
            case 3:
            listMembers()
            break;
            case 4:
            listTrainers()
            break;
            case 5:
            registerSchedules()
            break;
            case 6:
            listSchedules()
            break;
            case 7:
            registerWorkoutPlans()
            break;
            case 8:
            listWorkoutPlans()
            break;
            case 9:
            registerAloneClasses()
            break;
            case 10:
            listAloneClasses()
            break;
            case 11:
            registerGroupClasses()
            break;
            case 12:
            listGroupClasses()
            break;
            case 13:
            listAloneClasses()
            print("Escreva o id da aula que pretende atualizar: ")
            let id = readLine()
            updateAloneClasses(id: Int(id!)!)
            break;
            case 14:
            listGroupClasses()
            print("Escreva o id da aula que pretende atualizar: ")
            let id = readLine()
            updateGroupClasses(id: Int(id!)!)
            case 15:
            listAloneClasses()
            print("Escreva o id da aula que pretende eliminar: ")
            let id = readLine()
            deleteAloneClasses(id: Int(id!)!)
            break;
            case 16:
            listGroupClasses()
            print("Escreva o id da aula que pretende atualizar: ")
            let id = readLine()
            deleteGroupClasses(id: Int(id!)!)
            default:
            print("Opção inválida!")
            print("")
            break;
        }
    }
    else
    {
        break;
    }
}
print("Obrigado por utilizar o nosso ginásio!")
