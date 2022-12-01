//
//  SQLiteDatabase.swift
//  CSE335StoolBar
//
//  Created by Henry Reed on 11/30/22.
//

import Foundation
import SQLite3

let dbURL = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
private enum Database: String {
  case db
  
  var path: String? {
    return dbURL?.appendingPathComponent("\(self.rawValue).sqlite").relativePath
  }
}
public let dbPath = Database.db.path

enum SQLiteError: Error {
  case OpenDatabase(message: String)
  case Prepare(message: String)
  case Step(message: String)
  case Bind(message: String)
}

class SQLiteDatabase {
    private let dbPointer: OpaquePointer?
    private init(dbPointer: OpaquePointer?) {
    self.dbPointer = dbPointer
    }
    deinit {
        sqlite3_close(dbPointer)
    }
    static func open(path: String) throws -> SQLiteDatabase {
      var db: OpaquePointer?
      // 1
      if sqlite3_open(path, &db) == SQLITE_OK {
        // 2
        return SQLiteDatabase(dbPointer: db)
      } else {
        // 3
        defer {
          if db != nil {
            sqlite3_close(db)
          }
        }
        if let errorPointer = sqlite3_errmsg(db) {
          let message = String(cString: errorPointer)
          throw SQLiteError.OpenDatabase(message: message)
        } else {
          throw SQLiteError
            .OpenDatabase(message: "No error message provided from sqlite.")
        }
      }
    }
    var errorMessage: String {
      if let errorPointer = sqlite3_errmsg(dbPointer) {
        let errorMessage = String(cString: errorPointer)
        return errorMessage
      } else {
        return "No error message provided from sqlite."
      }
    }
}
extension SQLiteDatabase {
 func prepareStatement(sql: String) throws -> OpaquePointer? {
  var statement: OpaquePointer?
  guard sqlite3_prepare_v2(dbPointer, sql, -1, &statement, nil)
      == SQLITE_OK else {
    throw SQLiteError.Prepare(message: errorMessage)
  }
  return statement
 }
}
protocol SQLTable {
  static var createStatement: String { get }
}
extension Bet: SQLTable {
  static var createStatement: String {
    return """
    CREATE TABLE Bet(
        team1 CHAR(255),
        team2 CHAR(255),
        gameDateTime CHAR(255),
        odds DOUBLE,
        betType CHAR(255),
        betAmount DOUBLE,
        payout DOUBLE,
        betOver INT,
        betWon INT,
        betID INT PRIMARY KEY NOT NULL
    );
    """
  }
}
extension SQLiteDatabase {
  func createTable(table: SQLTable.Type) throws {
    // 1
    let createTableStatement = try prepareStatement(sql: table.createStatement)
    // 2
    defer {
      sqlite3_finalize(createTableStatement)
    }
    // 3
    guard sqlite3_step(createTableStatement) == SQLITE_DONE else {
      throw SQLiteError.Step(message: errorMessage)
    }
    print("\(table) table created.")
  }
}
extension SQLiteDatabase {
    func insertBet(bet: Bet) throws {
        let insertSql = "INSERT INTO Bet VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?);"
        let insertStatement = try prepareStatement(sql: insertSql)
        defer {
            sqlite3_finalize(insertStatement)
        }
        var betOver = 0
        var betWon = 0
        if (bet.betOver){
            betOver = 1
        }
        if (bet.betWon){
            betWon = 1
        }
        let team1: String = bet.team1
        let team2: String = bet.team2
        let gameDateTime: String = bet.gameDateTime
        let betType: String = bet.betType
        guard
            sqlite3_bind_text(insertStatement, 1, team1, -1, nil) == SQLITE_OK  &&
            sqlite3_bind_text(insertStatement, 2, team2, -1, nil) == SQLITE_OK &&
            sqlite3_bind_text(insertStatement, 3, gameDateTime, -1, nil) == SQLITE_OK &&
            sqlite3_bind_double(insertStatement, 4, bet.odds) == SQLITE_OK &&
            sqlite3_bind_text(insertStatement, 5, betType, -1, nil) == SQLITE_OK &&
            sqlite3_bind_double(insertStatement, 6, bet.betAmount) == SQLITE_OK &&
            sqlite3_bind_double(insertStatement, 7, bet.payout) == SQLITE_OK &&
            sqlite3_bind_int(insertStatement, 8, Int32(betOver)) == SQLITE_OK &&
            sqlite3_bind_int(insertStatement, 9, Int32(betWon)) == SQLITE_OK &&
            sqlite3_bind_int(insertStatement, 10, Int32(bet.betID)) == SQLITE_OK
        else {
            throw SQLiteError.Bind(message: errorMessage)
        }
        guard sqlite3_step(insertStatement) == SQLITE_DONE else {
            throw SQLiteError.Step(message: errorMessage)
        }
        print("Successfully inserted row.")
    }
}
extension SQLiteDatabase {
    func bet(betID: Int) -> Bet? {
        let querySql = "SELECT * FROM Bet WHERE betID = ?;"
        guard let queryStatement = try? prepareStatement(sql: querySql) else {
            return nil
        }
        defer {
            sqlite3_finalize(queryStatement)
        }
        guard sqlite3_bind_int(queryStatement, 1, Int32(betID)) == SQLITE_OK else {
            return nil
        }
        guard sqlite3_step(queryStatement) == SQLITE_ROW else {
            return nil
        }
        guard let queryResultCol1 = sqlite3_column_text(queryStatement, 0) else {
            print("Query result is nil.")
            return nil
        }
        guard let queryResultCol2 = sqlite3_column_text(queryStatement, 1) else {
            print("Query result is nil.")
            return nil
        }
        guard let queryResultCol3 = sqlite3_column_text(queryStatement, 2) else {
            print("Query result is nil.")
            return nil
        }
        let odds = sqlite3_column_double(queryStatement, 3)
        guard let queryResultCol5 = sqlite3_column_text(queryStatement, 4) else {
            print("Query result is nil.")
            return nil
        }
        let betAmount = sqlite3_column_double(queryStatement, 5)
        let payout = sqlite3_column_double(queryStatement, 6)
        let betOver = sqlite3_column_int(queryStatement, 7)
        let betWon = sqlite3_column_int(queryStatement, 8)
        let betID = sqlite3_column_int(queryStatement, 9)
        let team1 = String(cString: queryResultCol1) as NSString
        let team2 = String(cString: queryResultCol2) as NSString
        let gameDateTime = String(cString: queryResultCol3) as NSString
        let betType = String(cString: queryResultCol5) as NSString
        var boolBetOver = false
        var boolBetWon = false
        if (betOver == 1){
            boolBetOver = true
        }
        if (betWon == 1){
            boolBetWon = true
        }
        return Bet(Team1: team1 as String, Team2: team2 as String, GameDateTime: gameDateTime as String, Odds: odds, BetType: betType as String, BetAmount: betAmount, Payout: payout, BetOver: boolBetOver, BetWon: boolBetWon, ID: Int(betID))
    }
}
extension SQLiteDatabase {
    func makeBetArray() -> [Bet]{
        var betArray: [Bet] = []
        let querySql = "SELECT * FROM Bet"
        guard let queryStatement = try? prepareStatement(sql: querySql) else {
            return []
        }
        defer {
            sqlite3_finalize(queryStatement)
        }
        while (sqlite3_step(queryStatement) == SQLITE_ROW){
            guard let queryResultCol1 = sqlite3_column_text(queryStatement, 0) else {
                print("Query result is nil.")
                return []
            }
            guard let queryResultCol2 = sqlite3_column_text(queryStatement, 1) else {
                print("Query result is nil.")
                return []
            }
            guard let queryResultCol3 = sqlite3_column_text(queryStatement, 2) else {
                print("Query result is nil.")
                return []
            }
            let odds = sqlite3_column_double(queryStatement, 3)
            guard let queryResultCol5 = sqlite3_column_text(queryStatement, 4) else {
                print("Query result is nil.")
                return []
            }
            let betAmount = sqlite3_column_double(queryStatement, 5)
            let payout = sqlite3_column_double(queryStatement, 6)
            let betOver = sqlite3_column_int(queryStatement, 7)
            let betWon = sqlite3_column_int(queryStatement, 8)
            let betID = sqlite3_column_int(queryStatement, 9)
            let team1 = String(cString: queryResultCol1) as NSString
            let team2 = String(cString: queryResultCol2) as NSString
            let gameDateTime = String(cString: queryResultCol3) as NSString
            let betType = String(cString: queryResultCol5) as NSString
            var boolBetOver = false
            var boolBetWon = false
            if (betOver == 1){
                boolBetOver = true
            }
            if (betWon == 1){
                boolBetWon = true
            }
            betArray.append(Bet(Team1: team1 as String, Team2: team2 as String, GameDateTime: gameDateTime as String, Odds: odds, BetType: betType as String, BetAmount: betAmount, Payout: payout, BetOver: boolBetOver, BetWon: boolBetWon, ID: Int(betID)))
        }
        return betArray
    }
}






