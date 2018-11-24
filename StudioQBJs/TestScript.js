function TestTask(taskId,args)
{
    console.log(taskId);
    console.log(args);
    console.log("Test");

    taskProgress(JSON.stringify({"progesss":50}),taskId);
    taskDone(JSON.stringify({"progress":100}),taskId);
}

TestTask;
