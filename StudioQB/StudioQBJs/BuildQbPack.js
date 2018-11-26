function buildQbPack(taskId,args){
    var appId = QbJSEngineObject.appId();
    var jargs = JSON.parse(args);

    var pWriter = include("QbCore::QbAppPackageWriter");
    pWriter.setVersion(jargs["version"]);
    pWriter.setPackageVariant(jargs["export_format"]);
    pWriter.resetPublicKey();
    if(pWriter.createPackage(jargs["source_dir"],jargs["output_dir"])){
        taskDone(JSON.stringify({"status":1,"message":jargs["name"]+" package created @"+jargs["output_dir"]}),taskId);
    }
    else{
        taskDone(JSON.stringify({"status":0,"message":"failed to create package of "+jargs["name"]}),taskId);
    }
}


buildQbPack;
