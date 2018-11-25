pragma Singleton

import Qb 1.0
import Qb.Core 1.0
import Qb.ExSql 1.0
import Qb.Core.Private 1.0

import QtQml 2.11
import QtQuick 2.11

import "../ZeUi" 1.0 as ZeUi

Item {
    id: objStudioQBOne

    property alias codeEngine: objCodeExecutionEngine
    property alias loggingCategory: objLoggingCategory
    property alias projectListModel: objProjectListModel

    LoggingCategory {
        id: objLoggingCategory
        name: "com.github.openqb.StudioQB"
    }

    QbJSEngineEx{
        id: objCodeExecutionEngine
    }

    QbExSql{
        id: objExSql
    }


    /*ProjectList*/
    ListModel{
        id: objProjectListModel
    }

    function dbProjectListSetup(){
        var qtable1 = "CREATE TABLE IF NOT EXISTS ProjectList(pid INTEGER PRIMARY KEY,name TEXT,source_dir TEXT,output_dir TEXT,export_format TEXT,json TEXT);"
        objExSql.open();
        if(objExSql.isOpen()){
            objExSql.beginQuery();
            if(objExSql.exec(qtable1)){
                console.log(objLoggingCategory,"ProjectList table created.");
            }
            else{
                console.error(objLoggingCategory,objExSql.lastQueryError());
            }
            objExSql.endQuery();
        }
        else{
            console.error(objLoggingCategory,"Db Path:"+dbPath());
            console.error(objLoggingCategory,"Db is not open.");
        }
    }

    function searchInProjectListModel(tag){
        var q = "SELECT * FROM ProjectList WHERE"
                +" name LIKE '%"+tag+"%' COLLATE NOCASE"
                +" OR source_dir LIKE '%"+tag+"%' COLLATE NOCASE"
                +" OR output_dir LIKE '%"+tag+"%' COLLATE NOCASE;";

        objProjectListModel.clear();
        objExSql.open();
        if(objExSql.isOpen()){
            objExSql.beginQuery();
            if(objExSql.exec(q)){
                if(objExSql.exec()){
                    while(objExSql.next()){
                        var data = {};
                        data["pid"] = objExSql.value("pid");
                        data["name"] = objExSql.value("name");
                        data["source_dir"] = objExSql.value("source_dir");
                        data["output_dir"] = objExSql.value("output_dir");
                        data["export_format"] = objExSql.value("export_format");
                        data["json"] = objExSql.value("json");
                        objProjectListModel.append(data);

                    }
                }
                else{
                    console.error(objLoggingCategory,"Failed to execute query inside getProjectById");
                    console.error(objLoggingCategory,objExSql.lastQueryError());
                }
            }
            else{
                console.error(objLoggingCategory,"Failed to prepare query inside getProjectById");
            }
            objExSql.endQuery();
        }
        else{
            console.error(objLoggingCategory,"Db is not open.");
        }

    }

    function refreshProjectListModel(){
        objProjectListModel.clear();

        objExSql.open();
        if(objExSql.isOpen()){
            objExSql.beginQuery();
            if(objExSql.exec("SELECT * FROM ProjectList;")){
                if(objExSql.exec()){
                    while(objExSql.next()){
                        var data = {};
                        data["pid"] = objExSql.value("pid");
                        data["name"] = objExSql.value("name");
                        data["source_dir"] = objExSql.value("source_dir");
                        data["output_dir"] = objExSql.value("output_dir");
                        data["export_format"] = objExSql.value("export_format");
                        data["json"] = objExSql.value("json");
                        objProjectListModel.append(data);

                    }
                }
                else{
                    console.error(objLoggingCategory,"Failed to execute query inside getProjectById");
                    console.error(objLoggingCategory,objExSql.lastQueryError());
                }
            }
            else{
                console.error(objLoggingCategory,"Failed to prepare query inside getProjectById");
            }
            objExSql.endQuery();
        }
        else{
            console.error(objLoggingCategory,"Db is not open.");
        }
    }

    function isProjectExists(source_dir){
        objExSql.open();
        if(objExSql.isOpen()){
            var exists = false;
            objExSql.beginQuery();
            if(objExSql.prepare("SELECT COUNT(*) FROM ProjectList WHERE source_dir=:source_dir;")){
                objExSql.bindValue(":source_dir",source_dir,QbExSql.STRING);
                if(objExSql.exec()){
                    while(objExSql.next()){
                        exists = objExSql.value("COUNT(*)")>0
                    }
                }
                else{
                    console.error(objLoggingCategory,"Failed to execute query inside isProjectExists");
                    console.error(objLoggingCategory,objExSql.lastQueryError());
                }
            }
            else{
                console.error(objLoggingCategory,"Failed to prepare query inside isProjectExists");
            }
            objExSql.endQuery();
            return exists;
        }
        else{
            console.error(objLoggingCategory,"Db is not open.");
        }

        return false;
    }

    function addProject(name,source_dir,output_dir,export_format,json)
    {
        var success = false;
        objExSql.open();
        if(objExSql.isOpen()){
            objExSql.beginQuery();
            if(objExSql.prepare("INSERT INTO ProjectList(name,source_dir,output_dir,export_format,json) VALUES(:name,:source_dir,:output_dir,:export_format,:json);")){
                objExSql.bindValue(":name",name,QbExSql.STRING);
                objExSql.bindValue(":source_dir",source_dir,QbExSql.STRING);
                objExSql.bindValue(":output_dir",output_dir,QbExSql.STRING);
                objExSql.bindValue(":export_format",export_format,QbExSql.STRING);
                objExSql.bindValue(":json",json,QbExSql.STRING);
                if(objExSql.exec()){
                    success = true;
                }
                else{
                    success = false;
                    console.log(objLoggingCategory,objExSql.lastQueryError());
                }
            }
            objExSql.endQuery();
        }

        return success;
    }

    function updateProject(pid,name,source_dir,output_dir,export_format,json)
    {
        var success = false;
        objExSql.open();
        if(objExSql.isOpen()){
            objExSql.beginQuery();
            if(objExSql.prepare("UPDATE ProjectList SET name=:name,source_dir=:source_dir,output_dir=:output_dir,export_format=:export_format,json=:json WHERE pid=:pid;")){
                objExSql.bindValue(":pid",pid,QbExSql.INT32);
                objExSql.bindValue(":name",name,QbExSql.STRING);
                objExSql.bindValue(":source_dir",source_dir,QbExSql.STRING);
                objExSql.bindValue(":output_dir",output_dir,QbExSql.STRING);
                objExSql.bindValue(":export_format",export_format,QbExSql.STRING);
                objExSql.bindValue(":json",json,QbExSql.STRING);
                if(objExSql.exec()){
                    success = true;
                }
                else{
                    success = false;
                    console.log(objLoggingCategory,objExSql.lastQueryError());
                }
            }
            objExSql.endQuery();
        }

        return success;
    }

    function getProject(source_dir){
        var data = {};

        objExSql.open();
        if(objExSql.isOpen()){
            objExSql.beginQuery();
            if(objExSql.prepare("SELECT * FROM ProjectList WHERE source_dir=:source_dir;")){
                objExSql.bindValue(":source_dir",source_dir,QbExSql.INT32);
                if(objExSql.exec()){
                    if(objExSql.next()){
                        data["pid"] = objExSql.value("pid");
                        data["name"] = objExSql.value("name");
                        data["source_dir"] = objExSql.value("source_dir");
                        data["output_dir"] = objExSql.value("output_dir");
                        data["export_format"] = objExSql.value("export_format");
                        data["json"] = objExSql.value("json");
                    }
                }
                else{
                    console.error(objLoggingCategory,"Failed to execute query inside getProjectById");
                    console.error(objLoggingCategory,objExSql.lastQueryError());
                }
            }
            else{
                console.error(objLoggingCategory,"Failed to prepare query inside getProjectById");
            }
            objExSql.endQuery();
        }
        else{
            console.error(objLoggingCategory,"Db is not open.");
        }

        return data;
    }

    function getProjectById(pid){
        var data = {};

        objExSql.open();
        if(objExSql.isOpen()){
            objExSql.beginQuery();
            if(objExSql.prepare("SELECT * FROM ProjectList WHERE pid=:pid;")){
                objExSql.bindValue(":pid",pid,QbExSql.INT32);
                if(objExSql.exec()){
                    if(objExSql.next()){
                        data["pid"] = objExSql.value("pid");
                        data["name"] = objExSql.value("name");
                        data["source_dir"] = objExSql.value("source_dir");
                        data["output_dir"] = objExSql.value("output_dir");
                        data["export_format"] = objExSql.value("export_format");
                        data["json"] = objExSql.value("json");
                    }
                }
                else{
                    console.error(objLoggingCategory,"Failed to execute query inside getProjectById");
                    console.error(objLoggingCategory,objExSql.lastQueryError());
                }
            }
            else{
                console.error(objLoggingCategory,"Failed to prepare query inside getProjectById");
            }
            objExSql.endQuery();
        }
        else{
            console.error(objLoggingCategory,"Db is not open.");
        }

        return data;
    }

    function removeProjectFromProjectListById(pid){
        var success = false;
        objExSql.open();
        if(objExSql.isOpen()){
            objExSql.beginQuery();
            if(objExSql.prepare("DELETE FROM ProjectList WHERE pid=:pid;")){
                objExSql.bindValue(":pid",pid,QbExSql.INT32);
                if(objExSql.exec()){
                    success = true;
                }
                else{
                    console.error(objLoggingCategory,"Failed to execute query inside deleteProjectById");
                    console.error(objLoggingCategory,objExSql.lastQueryError());
                }
            }
            else{
                console.error(objLoggingCategory,"Failed to prepare query inside deleteProjectById");
            }
            objExSql.endQuery();
        }
        else{
            console.error(objLoggingCategory,"Db is not open.");
        }

        return success;
    }

    function dbPath(){
        return ZeUi.ZBLib.appUi.absoluteDatabasePath("StudioQB");
    }

    Component.onCompleted: {
        objCodeExecutionEngine.setAppId(ZeUi.ZBLib.appUi.appId);
        objExSql.setSQLDb(dbPath());
        objStudioQBOne.dbProjectListSetup();
    }
}
