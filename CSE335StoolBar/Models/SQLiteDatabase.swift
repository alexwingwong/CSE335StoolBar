//
//  SQLiteDatabase.swift
//  CSE335StoolBar
//
//  Created by Henry Reed on 11/28/22.
//

import Foundation
import SQLite3

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
    fileprivate var errorMessage: String {
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
        gameDateTime CHAR(255) PRIMARY KEY NOT NULL,
        odds DOUBLE,
        betType CHAR(255),
        betAmount DOUBLE,
        payout DOUBLE,
        betOver INT,
        betWon INT
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
        let insertSql = "INSERT INTO Bet (team1, team2, gameDateTime, odds, betType, betAmount, payout, betOver, betWon) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?);"
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
            sqlite3_bind_int(insertStatement, 9, Int32(betWon)) == SQLITE_OK
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
    func bet(gameDateTime: String) -> Bet? {
        let querySql = "SELECT * FROM Bet WHERE gameDateTime = ?;"
        guard let queryStatement = try? prepareStatement(sql: querySql) else {
            return nil
        }
        defer {
            sqlite3_finalize(queryStatement)
        }
        guard sqlite3_bind_text(queryStatement, 1, gameDateTime, -1, nil) == SQLITE_OK else {
            return nil
        }
        guard sqlite3_step(queryStatement) == SQLITE_ROW else {
            return nil
        }
        let id = sqlite3_column_int(queryStatement, 0)
        guard let queryResultCol1 = sqlite3_column_text(queryStatement, 1) else {
            print("Query result is nil.")
            return nil
        }
        let name = String(cString: queryResultCol1) as NSString
        return Contact(id: id, name: name)
    }
}







